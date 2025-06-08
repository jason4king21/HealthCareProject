
{% macro create_raw_survey_summary_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SURVEY_SUMMARY (
    "CMS Certification Number (CCN)" STRING,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Inspection Cycle" NUMBER,
    "Health Survey Date" STRING,
    "Fire Safety Survey Date" STRING,
    "Total Number of Health Deficiencies" NUMBER,
    "Total Number of Fire Safety Deficiencies" NUMBER,
    "Count of Freedom from Abuse and Neglect and Exploitation Deficiencies" NUMBER,
    "Count of Quality of Life and Care Deficiencies" NUMBER,
    "Count of Resident Assessment and Care Planning Deficiencies" NUMBER,
    "Count of Nursing and Physician Services Deficiencies" NUMBER,
    "Count of Resident Rights Deficiencies" NUMBER,
    "Count of Nutrition and Dietary Deficiencies" NUMBER,
    "Count of Pharmacy Service Deficiencies" NUMBER,
    "Count of Environmental Deficiencies" NUMBER,
    "Count of Administration Deficiencies" NUMBER,
    "Count of Infection Control Deficiencies" NUMBER,
    "Count of Emergency Preparedness Deficiencies" NUMBER,
    "Count of Automatic Sprinkler Systems Deficiencies" NUMBER,
    "Count of Construction Deficiencies" NUMBER,
    "Count of Services Deficiencies" NUMBER,
    "Count of Corridor Walls and Doors Deficiencies" NUMBER,
    "Count of Egress Deficiencies" NUMBER,
    "Count of Electrical Deficiencies" NUMBER,
    "Count of Emergency Plans and Fire Drills Deficiencies" NUMBER,
    "Count of Fire Alarm Systems Deficiencies" NUMBER,
    "Count of Smoke Deficiencies" NUMBER,
    "Count of Interior Deficiencies" NUMBER,
    "Count of Gas and Vacuum and Electrical Systems Deficiencies" NUMBER,
    "Count of Hazardous Area Deficiencies" NUMBER,
    "Count of Illumination and Emergency Power Deficiencies" NUMBER,
    "Count of Laboratories Deficiencies" NUMBER,
    "Count of Medical Gases and Anaesthetizing Areas Deficiencies" NUMBER,
    "Count of Smoking Regulations Deficiencies" NUMBER,
    "Count of Miscellaneous Deficiencies" NUMBER,
    "Location" STRING,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
