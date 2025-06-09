
{{ config(
    materialized='incremental',
    unique_key='table_name || '_' || run_date',
    incremental_strategy='insert_overwrite'
) }}

WITH columns_info AS (

    SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'RAW'
      AND TABLE_CATALOG = 'HEALTHCARE'
      AND TABLE_NAME = UPPER('{{ var("target_table") }}')
    ORDER BY ORDINAL_POSITION

), base_info AS (

    SELECT COUNT(*) AS row_count
    FROM HEALTHCARE.RAW.{{ var("target_table") }}

), null_counts AS (

    SELECT
        {% for col in columns_info.columns[0].values() %}
        SUM(CASE WHEN "{{ col }}" IS NULL THEN 1 ELSE 0 END) AS "{{ col }}_null_count"{% if not loop.last %},{% endif %}
        {% endfor %}
    FROM HEALTHCARE.RAW.{{ var("target_table") }}

), duplicates_info AS (

    {% for col in columns_info.columns[0].values() %}
    SELECT
        '{{ col }}' AS column_name,
        COUNT(*) AS duplicate_count
    FROM (
        SELECT "{{ col }}", COUNT(*) AS cnt
        FROM HEALTHCARE.RAW.{{ var("target_table") }}
        GROUP BY "{{ col }}"
        HAVING COUNT(*) > 1
    ) dup
    {% if not loop.last %}UNION ALL{% endif %}
    {% endfor %}

)

SELECT
    '{{ var("target_table") }}' AS table_name,
    CURRENT_TIMESTAMP() AS run_date,
    base_info.row_count,
    {% for col in columns_info.columns[0].values() %}
    null_counts."{{ col }}_null_count" AS "{{ col }}_null_count"{% if not loop.last %},{% endif %}
    {% endfor %}
FROM base_info, null_counts
