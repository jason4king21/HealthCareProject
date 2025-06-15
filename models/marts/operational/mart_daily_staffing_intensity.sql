-- models/marts/operational/mart_daily_staffing_intensity.sql
with daily AS (
  select
    provnum as provider_id,
    state,
    workdate,
    hrs_rn,
    hrs_lpn,
    hrs_med_aide,
    total_nurse_hours,
    mdscensus as census_count
  from {{ ref('stg_daily_nurse_staffing') }}
  where census_count > 0
)
select
  provider_id,
  state,
  workdate,
  hrs_rn / census_count as rn_hrs_per_resident,
  hrs_lpn / census_count as lpn_hrs_per_resident,
  hrs_med_aide / census_count as aide_hrs_per_resident,
  total_nurse_hours / census_count as total_hrs_per_resident
from daily
order by provider_id, workdate
