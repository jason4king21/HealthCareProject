{{ config(
    materialized='incremental',
    unique_key="table_name || '_' || run_date",
    incremental_strategy='insert_overwrite'
) }}

{% set column_names = [
    'CMS Certification Number (CCN)',
    'Provider Name',
    'Address Line 1',
    'Address Line 2',
    'City/Town',
    'State',
    'ZIP Code',
    'County/Parish',
    'Telephone Number',
    'CMS Region',
    'Measure Code',
    'Score',
    'Footnote',
    'Start Date',
    'End Date',
    'MeasureDateRange'
] %}

WITH base_info AS (
    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.SWING_BED_SNF_DATA
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
    FROM HEALTHCARE.RAW.SWING_BED_SNF_DATA
)

SELECT
    'SWING_BED_SNF_DATA' AS table_name,
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