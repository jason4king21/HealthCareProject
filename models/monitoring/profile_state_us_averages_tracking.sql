{{ config(
    materialized='incremental',
    unique_key="table_name || '_' || run_date",
    incremental_strategy='insert_overwrite'
) }}

{% set column_names = [
    'State or Nation',
    'Cycle 1 Total Number of Health Deficiencies',
    'Cycle 1 Total Number of Fire Safety Deficiencies',
    'Cycle 2 Total Number of Health Deficiencies',
    'Cycle 2 Total Number of Fire Safety Deficiencies',
    'Cycle 3 Total Number of Health Deficiencies',
    'Cycle 3 Total Number of Fire Safety Deficiencies',
    'Average Number of Residents per Day',
    'Reported Nurse Aide Staffing Hours per Resident per Day',
    'Reported LPN Staffing Hours per Resident per Day',
    'Reported RN Staffing Hours per Resident per Day',
    'Reported Licensed Staffing Hours per Resident per Day',
    'Reported Total Nurse Staffing Hours per Resident per Day',
    'Total number of nurse staff hours per resident per day on the weekend',
    'Registered Nurse hours per resident per day on the weekend',
    'Reported Physical Therapist Staffing Hours per Resident Per Day',
    'Total nursing staff turnover',
    'Registered Nurse turnover',
    'Number of administrators who have left the nursing home',
    'Nursing Case-Mix Index',
    'Case-Mix RN Staffing Hours per Resident per Day',
    'Case-Mix Total Nurse Staffing Hours per Resident per Day',
    'Case-Mix Weekend Total Nurse Staffing Hours per Resident per Day',
    'Number of Fines',
    'Fine Amount in Dollars',
    'Percentage of long stay residents whose need for help with daily activities has increased',
    'Percentage of long stay residents who lose too much weight',
    'Percentage of low risk long stay residents who lose control of their bowels or bladder',
    'Percentage of long stay residents with a catheter inserted and left in their bladder',
    'Percentage of long stay residents with a urinary tract infection',
    'Percentage of long stay residents who have depressive symptoms',
    'Percentage of long stay residents who were physically restrained',
    'Percentage of long stay residents experiencing one or more falls with major injury',
    'Percentage of long stay residents assessed and appropriately given the pneumococcal vaccine',
    'Percentage of long stay residents who received an antipsychotic medication',
    'Percentage of short stay residents assessed and appropriately given the pneumococcal vaccine',
    'Percentage of short stay residents who newly received an antipsychotic medication',
    'Percentage of long stay residents whose ability to move independently worsened',
    'Percentage of long stay residents who received an antianxiety or hypnotic medication',
    'Percentage of high risk long stay residents with pressure ulcers',
    'Percentage of long stay residents assessed and appropriately given the seasonal influenza vaccine',
    'Percentage of short stay residents who made improvements in function',
    'Percentage of short stay residents who were assessed and appropriately given the seasonal influenza vaccine',
    'Percentage of short stay residents who were rehospitalized after a nursing home admission',
    'Percentage of short stay residents who had an outpatient emergency department visit',
    'Number of hospitalizations per 1000 long-stay resident days',
    'Number of outpatient emergency department visits per 1000 long-stay resident days',
    'Processing Date'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.STATE_US_AVERAGES
), null_counts AS (
    SELECT
        {% for col in column_names %}
            {% set cleaned_col_name = col 
                | replace(" ", "_")
                | replace("(", "")
                | replace(")", "")
                | replace("/", "_")
                | replace("-", "_")
                | lower %}
        SUM(CASE WHEN "{{ col }}" IS NULL THEN 1 ELSE 0 END) AS "{{ cleaned_col_name }}_null_count"{% if not loop.last %},{% endif %}
        {% endfor %}
    FROM HEALTHCARE.RAW.STATE_US_AVERAGES
)

SELECT
    'STATE_US_AVERAGES' AS table_name,
    CURRENT_TIMESTAMP() AS run_date,
    base_info.row_count,
    {% for col in column_names %}
        {% set cleaned_col_name = col 
            | replace(" ", "_")
            | replace("(", "")
            | replace(")", "")
            | replace("/", "_")
            | replace("-", "_")
            | lower %}
    null_counts."{{ cleaned_col_name }}_null_count" AS "{{ cleaned_col_name }}_null_count"{% if not loop.last %},{% endif %}
    {% endfor %}
FROM base_info, null_counts