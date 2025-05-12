{% macro get_latest_csv_matching_pattern(pattern, stage_path) %}
    {% set list_query %}
        LIST @{{ stage_path }};
    {% endset %}

    {% set results = run_query(list_query) %}
    {% if execute %}
        {% set rows = results.columns[0].values %}
        {% set matching_files = [] %}

        {% for row in rows %}
            {% set file = row %}
            {% if file is match(pattern) %}
                {% do matching_files.append(file) %}
            {% endif %}
        {% endfor %}

        {% if matching_files | length == 0 %}
            {{ exceptions.raise("No matching file found in stage") }}
        {% endif %}

        {% set latest_file = matching_files | sort | last %}
        {{ log("Latest matching file: " ~ latest_file, info=True) }}
        {{ return(latest_file) }}
    {% endif %}
{% endmacro %}
