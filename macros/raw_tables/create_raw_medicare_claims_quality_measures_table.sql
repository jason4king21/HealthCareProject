
{% macro create_raw_medicare_claims_quality_measures_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.MEDICARE_CLAIMS_QUALITY_MEASURES (
    "CMS_Certification_Number_(CCN)" STRING,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Measure_Code" NUMBER,
    "Measure_Description" STRING,
    "Resident_type" STRING,
    "Adjusted_Score" FLOAT,
    "Observed_Score" FLOAT,
    "Expected_Score" FLOAT,
    "Footnote_for_Score" FLOAT,
    "Used_in_Quality_Measure_Five_Star_Rating" STRING,
    "Measure_Period" STRING,
    "Location" STRING,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
