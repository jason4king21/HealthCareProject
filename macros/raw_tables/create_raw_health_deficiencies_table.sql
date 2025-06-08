
{% macro create_raw_health_deficiencies_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.HEALTH_DEFICIENCIES (
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Survey_Date" STRING,
    "Survey_Type" STRING,
    "Deficiency_Prefix" STRING,
    "Deficiency_Category" STRING,
    "Deficiency_Tag_Number" NUMBER,
    "Deficiency_Description" STRING,
    "Scope_Severity_Code" STRING,
    "Deficiency_Corrected" STRING,
    "Correction_Date" STRING,
    "Inspection_Cycle" NUMBER,
    "Standard_Deficiency" STRING,
    "Complaint_Deficiency" STRING,
    "Infection_Control_Inspection_Deficiency" STRING,
    "Citation_under_IDR" STRING,
    "Citation_under_IIDR" STRING,
    "Location" STRING,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
