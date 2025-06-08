
{% macro create_raw_penalties_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.PENALTIES (
    "CMS_Certification_Number_(CCN)" STRING,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Penalty_Date" STRING,
    "Penalty_Type" STRING,
    "Fine_Amount" FLOAT,
    "Payment_Denial_Start_Date" STRING,
    "Payment_Denial_Length_in_Days" FLOAT,
    "Location" STRING,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
