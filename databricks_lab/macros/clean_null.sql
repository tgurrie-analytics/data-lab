{% macro clean_null(column_name) %}
    nullif({{ column_name }}, 'null')
{% endmacro %}