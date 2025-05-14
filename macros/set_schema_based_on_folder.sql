{% macro set_schema_based_on_folder(schema='silver') %}
  {% do log("Entering set_schema_based_on_folder macro", info=True) %}
  {% do log("Model: " ~ model, info=True) %}
  {% set nodes = graph.get('nodes', ({})) %}
{% set node = nodes.get('model_node_id') -%}
{%do log("Node: " ~node, info=True) %}
{{ log(node.path, info=True) }}
  {% if model %}
    {% do log("Model path: " ~ model.path, info=True) %}
    {% if model.path %}
      {% set folder =schema %}
      {% do log("Detected folder: " ~ folder, info=True) %}
      
      {% if folder == 'silver' %}
        {% set schema = 'silver' %}
      {% elif folder == 'gold' %}
        {% set schema = 'gold' %}
     
      {% else %}
        {% set schema = 'default' %}
      {% endif %}
      
      {% do log("Schema assigned: " ~ schema, info=True) %}
      {{ return(schema) }}
    {% else %}
      {% do log("Model path is undefined", info=True) %}
      {{ return('default') }}
    {% endif %}
  {% else %}
    {% do log("Model is undefined", info=True) %}
    {{ return('default') }}
  {% endif %}
{% endmacro %}