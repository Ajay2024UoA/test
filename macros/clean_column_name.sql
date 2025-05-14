{% macro clean_column_name(column_name) %}
    {% set col = column_name.upper() %}
    {% set col = col | regex_replace('[\\s:()$/-]+', '_') %}
    {% set col = col.rstrip('_') %}
    {% if match_regex(col, '^\\d') %}
        {% set col = 'COL_' ~ col %}
    {% endif %}
    {{ return(col) }}
{% endmacro %}
