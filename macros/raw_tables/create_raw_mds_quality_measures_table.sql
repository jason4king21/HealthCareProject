
{% macro create_raw_mds_quality_measures_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.MDS_QUALITY_MEASURES (
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Measure_Code" NUMBER,
    "Measure_Description" STRING,
    "Resident_type" STRING,
    "Q1_Measure_Score" FLOAT,
    "Footnote_for_Q1_Measure_Score" FLOAT,
    "Q2_Measure_Score" FLOAT,
    "Footnote_for_Q2_Measure_Score" FLOAT,
    "Q3_Measure_Score" FLOAT,
    "Footnote_for_Q3_Measure_Score" FLOAT,
    "Q4_Measure_Score" FLOAT,
    "Footnote_for_Q4_Measure_Score" FLOAT,
    "Four_Quarter_Average_Score" FLOAT,
    "Footnote_for_Four_Quarter_Average_Score" FLOAT,
    "Used_in_Quality_Measure_Five_Star_Rating" STRING,
    "Measure_Period" STRING,
    "Location" STRING,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
