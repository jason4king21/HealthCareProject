{{ config(
    materialized='incremental',
    unique_key="table_name || '_' || run_date",
    incremental_strategy='insert_overwrite'
) }}

{% set column_names = [
    'SNF VBP Program Ranking',
    'Footnote -- SNF VBP Program Ranking',
    'CMS Certification Number (CCN)',
    'Provider Name',
    'Provider Address',
    'City/Town',
    'State',
    'ZIP Code',
    'Baseline Period: FY 2019 Risk-Standardized Readmission Rate',
    'Footnote -- Baseline Period: FY 2019 Risk-Standardized Readmission Rate',
    'Performance Period: FY 2022 Risk-Standardized Readmission Rate',
    'Footnote -- Performance Period: FY 2022 Risk-Standardized Readmission Rate',
    'Achievement Score',
    'Footnote -- Achievement Score',
    'Improvement Score',
    'Footnote -- Improvement Score',
    'Performance Score',
    'Footnote -- Performance Score',
    'Incentive Payment Multiplier',
    'Footnote -- Incentive Payment Multiplier'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.FY_2024_SNF_VBP_FACILITY_PERFORMANCE
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
    FROM HEALTHCARE.RAW.FY_2024_SNF_VBP_FACILITY_PERFORMANCE
)

SELECT
    'FY_2024_SNF_VBP_FACILITY_PERFORMANCE' AS table_name,
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