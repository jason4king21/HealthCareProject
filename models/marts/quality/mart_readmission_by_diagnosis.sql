-- models/marts/quality/mart_readmission_by_diagnosis.sql
{{ config(materialized='view', schema='MARTS', alias='mart_readmission_by_diagnosis') }}

SELECT
  'Hospitalizations per 1000 days'         AS metric,
  avg(hosp_per_1000_longstay_resident_days)       AS avg_value
FROM {{ ref('stg_state_us_averages') }}
UNION ALL
SELECT
  'ED visits per 1000 days'                 AS metric,
  avg(ed_per_1000_longstay_resident_days)  AS avg_value
FROM {{ ref('stg_state_us_averages') }}
UNION ALL
SELECT
  '% Short-stay ED visits'                  AS metric,
  avg(pct_shortstay_ed_visit)           AS avg_value
FROM {{ ref('stg_state_us_averages') }}
UNION ALL
SELECT
  '% Short-stay rehospitalizations'         AS metric,
  avg(pct_shortstay_rehospitalized) AS avg_value
FROM {{ ref('stg_state_us_averages') }}
