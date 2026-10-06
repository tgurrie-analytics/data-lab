{% macro hash_columns(columns) %}
    md5(concat_ws('|', {{ columns | join(', ') }}))
{% endmacro %}