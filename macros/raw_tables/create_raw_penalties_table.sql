
{% macro create_raw_penalties_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.PENALTIES (
            CMS_CERTIFICATION_NUMBER STRING,
        PROVIDER_NAME STRING,
        PENALTY_DATE DATE,
        PENALTY_TYPE STRING,
        FINE_AMOUNT NUMBER,
        PROCESSING_DATE DATE
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
