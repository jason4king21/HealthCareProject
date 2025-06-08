
{% macro create_raw_health_deficiencies_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.HEALTH_DEFICIENCIES (
            CMS_CERTIFICATION_NUMBER STRING,
        PROVIDER_NAME STRING,
        SURVEY_DATE DATE,
        DEFICIENCY_DESCRIPTION STRING,
        DEFICIENCY_CORRECTED STRING,
        CORRECTION_DATE DATE,
        PROCESSING_DATE DATE
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
