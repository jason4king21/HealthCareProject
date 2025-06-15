-- mart_peak_staffing_day.sql

WITH daily AS (
  SELECT
    provnum as PROVIDER_ID,
    STATE,
    DAYOFWEEK(WORKDATE) AS DAY_OF_WEEK,
    -- Guard against zero census_count
    AVG(
      DIV0NULL(
        TOTAL_NURSE_HOURS,
        COALESCE(mdscensus, 0)
      )
    ) AS AVG_DAILY_INTENSITY
  FROM {{ ref('stg_daily_nurse_staffing') }}
  GROUP BY 1,2,3
)
SELECT *
FROM (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY PROVIDER_ID
      ORDER BY AVG_DAILY_INTENSITY DESC NULLS LAST
    ) AS RN
  FROM daily
)
WHERE RN = 1

