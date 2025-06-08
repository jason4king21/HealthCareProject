
{% macro create_raw_inspection_dates_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.INSPECTION_DATES (
            CMS_CERTIFICATION_NUMBER STRING,
        SURVEY_DATE DATE,
        TYPE_OF_SURVEY STRING,
        SURVEY_CYCLE NUMBER,
        PROCESSING_DATE DATE
        )
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
