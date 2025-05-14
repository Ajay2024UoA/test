{% macro load_csv_file_to_table(pattern, stage_path, database, schema) %}

    {% set file_list = get_file_list(stage_path) %}

  {{ log("File list: " ~ file_list, info=True) }}

    {% set parsed = get_table_name_and_date(pattern,file_list) %}

    {% if 'table_name' not in parsed or 'year' not in parsed or 'month' not in parsed %}
        {{ exceptions.raise_compiler_error("Parsed metadata from filename '" ~ filename ~ "' does not include expected keys: 'table_name', 'year', 'month'. Got: " ~ parsed | tojson) }}
    {% endif %}

    {% set table_name = parsed['table_name'] %}
    {% set filename = parsed['filename'] %}
    {% set year = parsed['year'] %}
    {% set month = parsed['month'] %}

    DELETE FROM {{ database }}.{{ schema }}.{{ table_name }};

    COPY INTO {{ database }}.{{ schema }}.{{ table_name }}
    FROM @{{ stage_path }}/{{ filename }}
    FILE_FORMAT = (FORMAT_NAME = 'MY_FILE_FORMAT');

    
{% endmacro %}
