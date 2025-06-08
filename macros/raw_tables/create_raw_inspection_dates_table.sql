
{% macro create_raw_inspection_dates_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.INSPECTION_DATES (
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Survey_Date" STRING,
    "Type_of_Survey" STRING,
    "Survey_Cycle" NUMBER,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
