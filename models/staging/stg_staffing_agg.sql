{{ config(materialized='table') }}

select
  provnum as provider_id,
  date_trunc('month', workdate)::date as month,
  avg(mdscensus)        as avg_census,
  avg(hrs_rn)           as avg_rn_hrs,
  avg(hrs_lpn)          as avg_lpn_hrs,
  avg(hrs_med_aide)         as avg_aide_hrs,
  avg(total_nurse_hours)  as avg_total_nurse_hrs,
  -- Compute total nurse hours per resident-day (HPPD)
  case 
    when avg(mdscensus) > 0 
    then avg(total_nurse_hours) / avg(mdscensus)
    else null
  end as nurse_hrs_per_resident_day
from {{ ref('stg_daily_nurse_staffing') }}
where mdscensus > 0
group by 1,2
