
{% macro create_raw_citation_code_lookup_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.CITATION_CODE_LOOKUP (
    "Deficiency_Prefix" STRING,
    "Deficiency_Tag_Number" NUMBER,
    "Deficiency_Prefix_and_Number" STRING,
    "Deficiency_Description" STRING,
    "Deficiency_Category" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
