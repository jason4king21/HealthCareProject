{{ config(
    materialized='incremental',
    unique_key="table_name || '_' || run_date",
    incremental_strategy='insert_overwrite'
) }}

{% set column_names = [
    'Baseline Period: FY 2019 National Average Readmission Rate',
    'Performance Period: FY 2022 National Average Readmission Rate',
    'FY 2024 Achievement Threshold',
    'FY 2024 Benchmark',
    'Range of Performance Scores',
    'Total Number of SNFs Receiving Value-Based Incentive Payments',
    'Range of Incentive Payment Multipliers',
    'Range of Value-Based Incentive Payments ($)',
    'Total Amount of Value-Based Incentive Payments ($)'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE
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
    FROM HEALTHCARE.RAW.FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE
)

SELECT
    'FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE' AS table_name,
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