{% macro get_file_list(stage_name) %}
    {{ log("LIST " ~stage_name, info=True) }}

    {% if execute %}

    {% set list_files_query %}
      LIST {{ stage_name }}
    {% endset %}

    {% set results = run_query(list_files_query) %}
    {% set file_rows = results.rows %}
     {{ log("file_rows: " ~ file_rows, info=True) }}

    {% for row in file_rows %}
     {{ log("row " ~ row[0], info=True) }}
      {% set file_path = row[0] %}

        {% set full_path = stage_name ~ '/' ~ file_path | replace(stage_name ~ '/', '') %}
        {% set file_name_with_ext = file_path.split('/')[-1] %}
        {% set file_name = file_name_with_ext.rsplit('.', 1)[0] %}
        
       
        {% do run_query(copy_sql) %}
        {{ log("file: " ~ file_name, info=True) }}
    {% endfor %}

   {{ return(file_rows) }}
    {% else %}
        {{ return([]) }}
    {% endif %}
{% endmacro %}