{% macro get_table_name_and_date( filename) %}

    {{ log("get_table_name_and_date() called" ~filename, info=True) }}
    
    {% set pattern_mapping = {
        "NH_PROVIDERINFO_": "NH_PROVIDER_INFO",
        "NH_STATEUSAVERAGES_": "NH_STATE_US_AVERAGES",
        "NH_DATACOLLECTIONINTERVALS_": "NH_DATA_COLLECTION_INTERVALS",
        "NH_SURVEYDATES_": "NH_SURVEY_DATES",
        "NH_FIRESAFETYCITATIONS_": "NH_FIRE_SAFETY_CITATIONS",
        "NH_HEALTHCITATIONS_": "NH_HEALTH_CITATIONS",
        "NH_CITATIONDESCRIPTIONS_": "NH_CITATION_DESCRIPTIONS",
        "NH_HLTHINSPECCUTPOINTSSTATE_": "NH_HLTH_INSPEC_CUTPOINTS_STATE",
        "NH_SURVEYSUMMARY_": "NH_SURVEY_SUMMARY",
        "NH_QUALITYMSR_MDS_": "NH_QUALITY_MSR_MDS",
        "NH_QUALITYMSR_CLAIMS_": "NH_QUALITY_MSR_CLAIMS",
        "NH_OWNERSHIP_": "NH_OWNERSHIP",
        "NH_PENALTIES_": "NH_PENALTIES",
        "NH_COVIDVAXPROVIDER_": "NH_COVID_VAX_PROVIDER",
        "NH_COVIDVAXAVERAGES_": "NH_COVID_VAX_AVERAGES",
        "SKILLED_NURSING_FACILITY_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA_": "SNF_QRP_NATIONAL_DATA",
        "SKILLED_NURSING_FACILITY_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA_": "SNF_QRP_PROVIDER_DATA",
        "SWING_BED_SNF_DATA_": "SWING_BED_SNF_DATA",
        "SNF_VBP_AGGREGATE_PERFORMANCE": "SNF_VBP_AGGREGATE_PERFORMANCE",
        "SNF_VBP_FACILITY_PERFORMANCE": "SNF_VBP_FACILITY_PERFORMANCE"
    } %}

{% set filename_upper = filename.upper()  %}
{{ log("Filename: " ~ filename, info=True) }}

  {% set ns = namespace(matched_pattern=none, table_name=none, match_type=none) %}

{% set filename_upper = filename.upper() %}

{% for pattern, name in pattern_mapping.items() %}
  {% set pattern_upper = pattern.upper() %}

  {% if pattern_upper in filename_upper %}
    {{ log("Pass: filename_upper:" ~ filename_upper ~ " pattern_upper:" ~ pattern_upper, info=True) }}

    {% set ns.matched_pattern = pattern_upper %}
    {{ log(" matched_pattern inside loop:" ~ ns.matched_pattern, info=True) }}
    {% set ns.table_name = name %}
    {% break %}
  {% endif %}
{% endfor %}

  {% if matched_pattern is none %}

    {{ exceptions.raise_compiler_error("No matching pattern found for filename `" ~ filename ~ "`") }}
  {% endif %}

  {# Extract parts of the filename for metadata #}
  {% set name_without_ext = filename.replace('.csv', '').replace('.CSV', '') %}
  {% set tokens = name_without_ext.split('_') %}

{% set valid_months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'] %}
{% set my = namespace(month=none, year=none) %}

{% for token in tokens %}
  {% set token_upper = token.upper() %}

  {# Case 1: Token is a 4-digit year #}
  {% if token | length == 4 and token.isdigit() %}
    {% set my.year = token %}

  {# Case 2: Token is a valid 3-letter month #}
  {% elif token_upper in valid_months %}
    {% set my.month = token_upper %}

  {# Case 3: Alphanumeric token like Oct2024 #}
  {% elif token | length == 7 and token.isalnum() %}
    {% set maybe_month = token_upper[0:3] %}
    {% set maybe_year = token_upper[3:7] %}
    {% if maybe_month in valid_months and maybe_year.isdigit() %}
      {% set my.month = maybe_month %}
      {% set my.year = maybe_year %}
    {% endif %}
  {% endif %}
{% endfor %}


{{ log(" filename:" ~ filename ~ " table_name:" ~ ns.table_name~ " month:" ~ my.month~ " year:" ~ my.year, info=True) }}
  {% do return({
    "filename": filename,
    "table_name": ns.table_name,
    "month": my.month,
    "year": my.year
  }) %}
{% endmacro %}


