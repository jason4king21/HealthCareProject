
{% macro create_raw_state_us_averages_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.STATE_US_AVERAGES (
    "State or Nation" STRING,
    "Cycle 1 Total Number of Health Deficiencies" FLOAT,
    "Cycle 1 Total Number of Fire Safety Deficiencies" FLOAT,
    "Cycle 2 Total Number of Health Deficiencies" FLOAT,
    "Cycle 2 Total Number of Fire Safety Deficiencies" FLOAT,
    "Cycle 3 Total Number of Health Deficiencies" FLOAT,
    "Cycle 3 Total Number of Fire Safety Deficiencies" FLOAT,
    "Average Number of Residents per Day" FLOAT,
    "Reported Nurse Aide Staffing Hours per Resident per Day" FLOAT,
    "Reported LPN Staffing Hours per Resident per Day" FLOAT,
    "Reported RN Staffing Hours per Resident per Day" FLOAT,
    "Reported Licensed Staffing Hours per Resident per Day" FLOAT,
    "Reported Total Nurse Staffing Hours per Resident per Day" FLOAT,
    "Total number of nurse staff hours per resident per day on the weekend" FLOAT,
    "Registered Nurse hours per resident per day on the weekend" FLOAT,
    "Reported Physical Therapist Staffing Hours per Resident Per Day" FLOAT,
    "Total nursing staff turnover" FLOAT,
    "Registered Nurse turnover" FLOAT,
    "Number of administrators who have left the nursing home" FLOAT,
    "Nursing Case-Mix Index" FLOAT,
    "Case-Mix RN Staffing Hours per Resident per Day" FLOAT,
    "Case-Mix Total Nurse Staffing Hours per Resident per Day" FLOAT,
    "Case-Mix Weekend Total Nurse Staffing Hours per Resident per Day" FLOAT,
    "Number of Fines" FLOAT,
    "Fine Amount in Dollars" NUMBER,
    "Percentage of long stay residents whose need for help with daily activities has increased" FLOAT,
    "Percentage of long stay residents who lose too much weight" FLOAT,
    "Percentage of low risk long stay residents who lose control of their bowels or bladder" FLOAT,
    "Percentage of long stay residents with a catheter inserted and left in their bladder" FLOAT,
    "Percentage of long stay residents with a urinary tract infection" FLOAT,
    "Percentage of long stay residents who have depressive symptoms" FLOAT,
    "Percentage of long stay residents who were physically restrained" FLOAT,
    "Percentage of long stay residents experiencing one or more falls with major injury" FLOAT,
    "Percentage of long stay residents assessed and appropriately given the pneumococcal vaccine" FLOAT,
    "Percentage of long stay residents who received an antipsychotic medication" FLOAT,
    "Percentage of short stay residents assessed and appropriately given the pneumococcal vaccine" FLOAT,
    "Percentage of short stay residents who newly received an antipsychotic medication" FLOAT,
    "Percentage of long stay residents whose ability to move independently worsened" FLOAT,
    "Percentage of long stay residents who received an antianxiety or hypnotic medication" FLOAT,
    "Percentage of high risk long stay residents with pressure ulcers" FLOAT,
    "Percentage of long stay residents assessed and appropriately given the seasonal influenza vaccine" FLOAT,
    "Percentage of short stay residents who made improvements in function" FLOAT,
    "Percentage of short stay residents who were assessed and appropriately given the seasonal influenza vaccine" FLOAT,
    "Percentage of short stay residents who were rehospitalized after a nursing home admission" FLOAT,
    "Percentage of short stay residents who had an outpatient emergency department visit" FLOAT,
    "Number of hospitalizations per 1000 long-stay resident days" FLOAT,
    "Number of outpatient emergency department visits per 1000 long-stay resident days" FLOAT,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
