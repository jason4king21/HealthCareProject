
{% macro create_table_if_not_exists(table_name) %}
    {% set table_exists_query %}
        SELECT COUNT(*) 
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_SCHEMA = 'RAW' 
          AND TABLE_NAME = UPPER('{{ table_name }}')
    {% endset %}

    {% set results = run_query(table_exists_query) %}
    {% if results.columns[0].values()[0] == 0 %}
        -- Table {{ table_name }} does not exist. Creating...
        {{ return('EXECUTE') }}
    {% else %}
        -- Table {{ table_name }} already exists. Skipping.
        {{ return('SKIP') }}
    {% endif %}
{% endmacro %}
