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
    'Survey Date',
    'Survey Type',
    'Deficiency Prefix',
    'Deficiency Category',
    'Deficiency Tag Number',
    'Deficiency Description',
    'Scope Severity Code',
    'Deficiency Corrected',
    'Correction Date',
    'Inspection Cycle',
    'Standard Deficiency',
    'Complaint Deficiency',
    'Infection Control Inspection Deficiency',
    'Citation under IDR',
    'Citation under IIDR',
    'Location',
    'Processing Date'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.HEALTH_DEFICIENCIES
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
    FROM HEALTHCARE.RAW.HEALTH_DEFICIENCIES
)

SELECT
    'HEALTH_DEFICIENCIES' AS table_name,
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
<<<<<<< HEAD
FROM base_info, null_counts
=======
FROM base_info, null_counts;
>>>>>>> 6f0cdd67d3f24875751ceaca4c27b1593b175a13
