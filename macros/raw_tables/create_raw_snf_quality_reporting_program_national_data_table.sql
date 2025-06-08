
{% macro create_raw_snf_quality_reporting_program_national_data_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SNF_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA (
    "CMS Certification Number (CCN)" STRING,
    "Measure Code" STRING,
    "Score" FLOAT,
    "Footnote" STRING,
    "Start Date" STRING,
    "End Date" STRING,
    "Measure Date Range" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
