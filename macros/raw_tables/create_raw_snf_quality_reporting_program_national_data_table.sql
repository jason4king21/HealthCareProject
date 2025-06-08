
{% macro create_raw_snf_quality_reporting_program_national_data_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SNF_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA (
    "CMS_Certification_Number_(CCN)" STRING,
    "Measure_Code" STRING,
    "Score" FLOAT,
    "Footnote" STRING,
    "Start_Date" STRING,
    "End_Date" STRING,
    "Measure_Date_Range" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
