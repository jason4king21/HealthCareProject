
{% macro create_raw_ownership_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.OWNERSHIP (
            CMS_CERTIFICATION_NUMBER STRING,
        PROVIDER_NAME STRING,
        OWNER_NAME STRING,
        OWNER_TYPE STRING,
        OWNERSHIP_PERCENTAGE STRING,
        ASSOCIATION_DATE STRING,
        PROCESSING_DATE DATE
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
