{% macro get_clean_table_name(filename) %}
    {# Remove .csv if present #}
    {% set filename = filename.replace('.csv', '').upper() %}

    {% set pattern_mapping = {
        'NH_PROVIDERINFO_[A-Z]{3}\\d{4}': 'NH_PROVIDER_INFO',
        'NH_STATEUSAVERAGES_[A-Z]{3}\\d{4}': 'NH_STATE_US_AVERAGES',
        'NH_DATACOLLECTIONINTERVALS_[A-Z]{3}\\d{4}': 'NH_DATA_COLLECTION_INTERVALS',
        'NH_SURVEYDATES_[A-Z]{3}\\d{4}': 'NH_SURVEY_DATES',
        'NH_FIRESAFETYCITATIONS_[A-Z]{3}\\d{4}': 'NH_FIRE_SAFETY_CITATIONS',
        'NH_HEALTHCITATIONS_[A-Z]{3}\\d{4}': 'NH_HEALTH_CITATIONS',
        'NH_CITATIONDESCRIPTIONS_[A-Z]{3}\\d{4}': 'NH_CITATION_DESCRIPTIONS',
        'NH_HLTHINSPECCUTPOINTSSTATE_[A-Z]{3}\\d{4}': 'NH_HLTH_INSPEC_CUTPOINTS_STATE',
        'NH_SURVEYSUMMARY_[A-Z]{3}\\d{4}': 'NH_SURVEY_SUMMARY',
        'NH_QUALITYMSR_MDS_[A-Z]{3}\\d{4}': 'NH_QUALITY_MSR_MDS',
        'NH_QUALITYMSR_CLAIMS_[A-Z]{3}\\d{4}': 'NH_QUALITY_MSR_CLAIMS',
        'NH_OWNERSHIP_[A-Z]{3}\\d{4}': 'NH_OWNERSHIP',
        'NH_PENALTIES_[A-Z]{3}\\d{4}': 'NH_PENALTIES',
        'NH_COVIDVAXPROVIDER_\\d{8}': 'NH_COVID_VAX_PROVIDER',
        'NH_COVIDVAXAVERAGES_\\d{8}': 'NH_COVID_VAX_AVERAGES',
        'SKILLED_NURSING_FACILITY_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA_[A-Z]{3}\\d{4}': 'SNF_QRP_NATIONAL_DATA',
        'SKILLED_NURSING_FACILITY_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA_[A-Z]{3}\\d{4}': 'SNF_QRP_PROVIDER_DATA',
        'SWING_BED_SNF_DATA_[A-Z]{3}\\d{4}': 'SWING_BED_SNF_DATA',
        'FY_\\d{4}_SNF_VBP_AGGREGATE_PERFORMANCE': 'SNF_VBP_AGGREGATE_PERFORMANCE',
        'FY_\\d{4}_SNF_VBP_FACILITY_PERFORMANCE': 'SNF_VBP_FACILITY_PERFORMANCE'
    } %}

    {% for pattern, table_name in pattern_mapping.items() %}
        {% if match_regex(filename, pattern) %}
            {{ return(table_name) }}
        {% endif %}
    {% endfor %}

    {# Default fallback cleaning if no pattern matched #}
    {% set fallback = filename | regex_replace('_[A-Z]{3}\\d{4}$', '') %}
    {% set fallback = fallback | regex_replace('_\\d{8}$', '') %}
    {{ return(fallback) }}
{% endmacro %}
