-- models/mart/staffing_breakdown_aggregated.sql
select
  date_trunc('month', ingestion_timestamp)::date as month,
  avg(reported_rn_staffing_hours_per_resident_per_day)     as avg_rn_hrs,
  avg(reported_lpn_staffing_hours_per_resident_per_day)    as avg_lpn_hrs,
  avg(reported_nurse_aide_staffing_hours_per_resident_per_day) as avg_aide_hrs,
  avg(reported_total_nurse_staffing_hours_per_resident_per_day) as avg_total_hrs,
  avg(average_number_of_residents_per_day)                 as avg_residents,
  avg(number_of_certified_beds)                            as avg_beds,
  case when avg(number_of_certified_beds) > 0 
       then avg(average_number_of_residents_per_day) / avg(number_of_certified_beds) end as occupancy_rate
from {{ ref('stg_provider_info') }}
group by 1
order by month
