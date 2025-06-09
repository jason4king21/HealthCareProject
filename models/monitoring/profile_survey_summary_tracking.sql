{{ config(
    materialized='incremental',
    unique_key="table_name || '_' || run_date",
    incremental_strategy='insert_overwrite'
) }}

{% set column_names = [
    'CMS Certification Number (CCN)',
    'Provider Name',
    'Provider Address',
    'City/Town',
    'State',
    'ZIP Code',
    'Inspection Cycle',
    'Health Survey Date',
    'Fire Safety Survey Date',
    'Total Number of Health Deficiencies',
    'Total Number of Fire Safety Deficiencies',
    'Count of Freedom from Abuse and Neglect and Exploitation Deficiencies',
    'Count of Quality of Life and Care Deficiencies',
    'Count of Resident Assessment and Care Planning Deficiencies',
    'Count of Nursing and Physician Services Deficiencies',
    'Count of Resident Rights Deficiencies',
    'Count of Nutrition and Dietary Deficiencies',
    'Count of Pharmacy Service Deficiencies',
    'Count of Environmental Deficiencies',
    'Count of Administration Deficiencies',
    'Count of Infection Control Deficiencies',
    'Count of Emergency Preparedness Deficiencies',
    'Count of Automatic Sprinkler Systems Deficiencies',
    'Count of Construction Deficiencies',
    'Count of Services Deficiencies',
    'Count of Corridor Walls and Doors Deficiencies',
    'Count of Egress Deficiencies',
    'Count of Electrical Deficiencies',
    'Count of Emergency Plans and Fire Drills Deficiencies',
    'Count of Fire Alarm Systems Deficiencies',
    'Count of Smoke Deficiencies',
    'Count of Interior Deficiencies',
    'Count of Gas and Vacuum and Electrical Systems Deficiencies',
    'Count of Hazardous Area Deficiencies',
    'Count of Illumination and Emergency Power Deficiencies',
    'Count of Laboratories Deficiencies',
    'Count of Medical Gases and Anaesthetizing Areas Deficiencies',
    'Count of Smoking Regulations Deficiencies',
    'Count of Miscellaneous Deficiencies',
    'Location',
    'Processing Date'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.SURVEY_SUMMARY
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
    FROM HEALTHCARE.RAW.SURVEY_SUMMARY
)

SELECT
    'SURVEY_SUMMARY' AS table_name,
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
FROM base_info, null_counts;