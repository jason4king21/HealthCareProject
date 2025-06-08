
{% macro create_raw_survey_summary_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SURVEY_SUMMARY (
            CMS_CERTIFICATION_NUMBER STRING,
        PROVIDER_NAME STRING,
        INSPECTION_CYCLE NUMBER,
        HEALTH_SURVEY_DATE DATE,
        TOTAL_NUMBER_OF_HEALTH_DEFICIENCIES NUMBER,
        TOTAL_NUMBER_OF_FIRE_SAFETY_DEFICIENCIES NUMBER,
        PROCESSING_DATE DATE
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
