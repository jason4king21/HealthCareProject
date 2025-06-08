
{% macro create_raw_snf_quality_reporting_program_provider_data_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SNF_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA (
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Provider_Name" STRING,
    "Address_Line_1" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "County_Parish" STRING,
    "Telephone_Number" STRING,
    "CMS_Region" NUMBER,
    "Measure_Code" STRING,
    "Score" STRING,
    "Footnote" STRING,
    "Start_Date" STRING,
    "End_Date" STRING,
    "Measure_Date_Range" STRING,
    "LOCATION1" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
