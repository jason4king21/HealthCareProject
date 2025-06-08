
{% macro create_raw_citation_code_lookup_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.CITATION_CODE_LOOKUP (
            DEFICIENCY_PREFIX STRING,
        DEFICIENCY_TAG_NUMBER NUMBER,
        DEFICIENCY_DESCRIPTION STRING,
        DEFICIENCY_CATEGORY STRING
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
