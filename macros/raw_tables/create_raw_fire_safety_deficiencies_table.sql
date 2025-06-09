
{% macro create_raw_fire_safety_deficiencies_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.FIRE_SAFETY_DEFICIENCIES (
    "CMS Certification Number (CCN)" STRING,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Survey Date" STRING,
    "Survey Type" STRING,
    "Deficiency Prefix" STRING,
    "Deficiency Category" STRING,
    "Deficiency Tag Number" NUMBER,
    "Tag Version" STRING,
    "Deficiency Description" STRING,
    "Scope Severity Code" STRING,
    "Deficiency Corrected" STRING,
    "Correction Date" STRING,
    "Inspection Cycle" NUMBER,
    "Standard Deficiency" STRING,
    "Complaint Deficiency" STRING,
    "Infection Control Inspection Deficiency" STRING,
    "Citation under IDR" STRING,
    "Citation under IIDR" STRING,
    "Location" STRING,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
