
{% macro create_raw_swing_bed_snf_data_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SWING_BED_SNF_DATA (
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Provider_Name" STRING,
    "Address_Line_1" STRING,
    "Address_Line_2" STRING,
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
    "MeasureDateRange" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
