-- models/marts/facility/mart_nursing_hppd_by_state.sql
{{ config(materialized='view', schema='MARTS', alias='mart_nursing_hppd_by_state') }}

WITH base AS (
  SELECT
    STATE,
    ADJUSTED_TOTAL_NURSE_STAFFING_HOURS_PER_RESIDENT_PER_DAY    AS total_hppd,
    ADJUSTED_WEEKEND_TOTAL_NURSE_STAFFING_HOURS_PER_RESIDENT_PER_DAY AS weekend_hppd
  FROM {{ ref('stg_provider_info') }}
  WHERE STATE IS NOT NULL
)

SELECT
  STATE,
  ROUND(AVG(total_hppd), 2)    AS avg_total_hppd,
  ROUND(AVG(weekend_hppd), 2)  AS avg_weekend_hppd
FROM base
GROUP BY STATE
ORDER BY STATE
