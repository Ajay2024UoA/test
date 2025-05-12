{% macro copy_from_stage_per_file(stage_name, pattern='.*') %}
  {% if execute %}

    {% set list_files_query %}
      LIST {{ stage_name }}
    {% endset %}

    {% set results = run_query(list_files_query) %}
    {% set file_rows = results.rows %}
      {{ log("file_rows: " ~ file_rows, info=True) }}
    {% for row in file_rows %}
      {% set file_path = row[0] %}
        {{ log("file_path: " ~ file_path, info=True) }}
        {% set full_path = stage_name ~ '/' ~ file_path | replace(stage_name ~ '/', '') %}
        {% set file_name_with_ext = file_path.split('/')[-1] %}
        {% set file_name = file_name_with_ext.rsplit('.', 1)[0] %}
    
         {% set parsed = get_table_name_and_date(file_name) %}
          {{ log("****************: " ~ parsed, info=True) }}
        {% if 'table_name' not in parsed or 'year' not in parsed or 'month' not in parsed %}
            {{ exceptions.raise_compiler_error("Parsed metadata from filename '" ~ file_name ~ "' does not include expected keys: 'table_name', 'year', 'month'. Got: " ~ parsed | tojson) }}
        {% endif %}
        
        {% set table_name = parsed['table_name'] %}
        {% set filename = parsed['filename'] %}
        {% set year = parsed['year'] %}
        {% set month = parsed['month'] %}

        {% set copy_sql %}
       {#  COPY INTO HEALTHCAREDB.BRONZE.{{ table_name }}
          FROM {{ stage_name }}/{{ file_name_with_ext }}
          FILE_FORMAT = (TYPE = CSV);#} 

          COPY INTO HEALTHCAREDB.BRONZE.{{ table_name }}
FROM  @HEALTHCAREDB.BRONZE.HEALTHCAREDB_STAGE/{{ filename }}

FILE_FORMAT = (
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)

        {% endset %}
{% do run_query(copy_sql) %}  
        
        {{ log("Executed: " ~ copy_sql, info=True) }}
    {% endfor %}

  {% else %}
    {{ log("Macro `copy_from_stage_per_file` skipped during parsing (execute=False)", info=True) }}
  {% endif %}
{% endmacro %}