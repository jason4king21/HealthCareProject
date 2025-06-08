
{% macro create_raw_medicare_claims_quality_measures_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.MEDICARE_CLAIMS_QUALITY_MEASURES (
            CMS_CERTIFICATION_NUMBER STRING,
        PROVIDER_NAME STRING,
        MEASURE_CODE NUMBER,
        MEASURE_DESCRIPTION STRING,
        ADJUSTED_SCORE NUMBER,
        PROCESSING_DATE DATE
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
