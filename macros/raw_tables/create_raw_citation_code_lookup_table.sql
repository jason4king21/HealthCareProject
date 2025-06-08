
{% macro create_raw_citation_code_lookup_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.CITATION_CODE_LOOKUP (
    "Deficiency Prefix" STRING,
    "Deficiency Tag Number" NUMBER,
    "Deficiency Prefix and Number" STRING,
    "Deficiency Description" STRING,
    "Deficiency Category" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
