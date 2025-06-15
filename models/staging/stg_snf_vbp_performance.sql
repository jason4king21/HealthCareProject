{{ config(materialized='table') }}

with raw as (
  select
    cast(CCN as varchar) as cms_certification_number_ccn,
    measure_id,
    measure_name,
    cast(result as float) as measure_result,
    cast(benchmark as float) as measure_benchmark,
    cast(achievement_score as float) as achievement_score,
    cast(improvement_score as float) as improvement_score,
    cast(performance_score as float) as performance_score,
    reporting_period_start,
    reporting_period_end
  from {{ source('RAW', 'FY_2024_SNF_VBP_FACILITY_PERFORMANCE') }}
)
select
  cms_certification_number_ccn,
  measure_id,
  measure_name,
  measure_result,
  measure_benchmark,
  achievement_score,
  improvement_score,
  performance_score,
  reporting_period_start,
  reporting_period_end
from raw
