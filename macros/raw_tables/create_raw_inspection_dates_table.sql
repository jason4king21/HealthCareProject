
{% macro create_raw_inspection_dates_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.INSPECTION_DATES (
    "CMS Certification Number (CCN)" STRING,
    "Survey Date" STRING,
    "Type of Survey" STRING,
    "Survey Cycle" NUMBER,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
