{% macro regex_search(string, pattern) %}
  {{ return(modules.re.search(pattern, string)) }}
{% endmacro %}

{% macro regex_match(pattern, string) %}
  {{ return(modules.re.match(pattern, string) is not none) }}
{% endmacro %}

