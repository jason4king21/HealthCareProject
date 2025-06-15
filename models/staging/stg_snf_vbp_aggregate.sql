{{ config(materialized='table') }}

select
  measure_id,
  measure_name,
  cast(numerator as int) as num_stays,
  cast(denominator as int) as total_stays,
  cast(national_baseline as float) as baseline_rate,
  cast(national_performance as float) as performance_rate
from {{ source('RAW', 'FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE') }}
