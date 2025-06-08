
{% macro create_raw_survey_summary_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SURVEY_SUMMARY (
    "CMS_Certification_Number_(CCN)" STRING,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Inspection_Cycle" NUMBER,
    "Health_Survey_Date" STRING,
    "Fire_Safety_Survey_Date" STRING,
    "Total_Number_of_Health_Deficiencies" NUMBER,
    "Total_Number_of_Fire_Safety_Deficiencies" NUMBER,
    "Count_of_Freedom_from_Abuse_and_Neglect_and_Exploitation_Deficiencies" NUMBER,
    "Count_of_Quality_of_Life_and_Care_Deficiencies" NUMBER,
    "Count_of_Resident_Assessment_and_Care_Planning_Deficiencies" NUMBER,
    "Count_of_Nursing_and_Physician_Services_Deficiencies" NUMBER,
    "Count_of_Resident_Rights_Deficiencies" NUMBER,
    "Count_of_Nutrition_and_Dietary_Deficiencies" NUMBER,
    "Count_of_Pharmacy_Service_Deficiencies" NUMBER,
    "Count_of_Environmental_Deficiencies" NUMBER,
    "Count_of_Administration_Deficiencies" NUMBER,
    "Count_of_Infection_Control_Deficiencies" NUMBER,
    "Count_of_Emergency_Preparedness_Deficiencies" NUMBER,
    "Count_of_Automatic_Sprinkler_Systems_Deficiencies" NUMBER,
    "Count_of_Construction_Deficiencies" NUMBER,
    "Count_of_Services_Deficiencies" NUMBER,
    "Count_of_Corridor_Walls_and_Doors_Deficiencies" NUMBER,
    "Count_of_Egress_Deficiencies" NUMBER,
    "Count_of_Electrical_Deficiencies" NUMBER,
    "Count_of_Emergency_Plans_and_Fire_Drills_Deficiencies" NUMBER,
    "Count_of_Fire_Alarm_Systems_Deficiencies" NUMBER,
    "Count_of_Smoke_Deficiencies" NUMBER,
    "Count_of_Interior_Deficiencies" NUMBER,
    "Count_of_Gas_and_Vacuum_and_Electrical_Systems_Deficiencies" NUMBER,
    "Count_of_Hazardous_Area_Deficiencies" NUMBER,
    "Count_of_Illumination_and_Emergency_Power_Deficiencies" NUMBER,
    "Count_of_Laboratories_Deficiencies" NUMBER,
    "Count_of_Medical_Gases_and_Anaesthetizing_Areas_Deficiencies" NUMBER,
    "Count_of_Smoking_Regulations_Deficiencies" NUMBER,
    "Count_of_Miscellaneous_Deficiencies" NUMBER,
    "Location" STRING,
    "Processing_Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
