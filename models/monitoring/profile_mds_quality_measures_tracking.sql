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
    'Measure Code',
    'Measure Description',
    'Resident type',
    'Q1 Measure Score',
    'Footnote for Q1 Measure Score',
    'Q2 Measure Score',
    'Footnote for Q2 Measure Score',
    'Q3 Measure Score',
    'Footnote for Q3 Measure Score',
    'Q4 Measure Score',
    'Footnote for Q4 Measure Score',
    'Four Quarter Average Score',
    'Footnote for Four Quarter Average Score',
    'Used in Quality Measure Five Star Rating',
    'Measure Period',
    'Location',
    'Processing Date'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.MDS_QUALITY_MEASURES
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
    FROM HEALTHCARE.RAW.MDS_QUALITY_MEASURES
)

SELECT
    'MDS_QUALITY_MEASURES' AS table_name,
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