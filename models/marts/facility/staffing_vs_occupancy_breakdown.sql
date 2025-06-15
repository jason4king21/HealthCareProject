-- models/mart/staffing_vs_occupancy_breakdown.sql
with usage as (
  select
    cms_certification_number_ccn as provider_id,
    date_trunc('month', ingestion_timestamp)::date as month,
    avg(average_number_of_residents_per_day)           as avg_residents,
    avg(number_of_certified_beds)                      as avg_beds,
    avg(reported_total_nurse_staffing_hours_per_resident_per_day)   as avg_total_nurse_hrs,
    avg(reported_rn_staffing_hours_per_resident_per_day)            as avg_rn_hrs,
    avg(reported_lpn_staffing_hours_per_resident_per_day)           as avg_lpn_hrs,
    avg(reported_nurse_aide_staffing_hours_per_resident_per_day)    as avg_aide_hrs
  from {{ ref('stg_provider_info') }}
  group by 1, month
)
select
  month,
  provider_id,
  avg_residents,
  avg_beds,
  avg_total_nurse_hrs,
  avg_rn_hrs,
  avg_lpn_hrs,
  avg_aide_hrs,
  case when avg_beds > 0 then avg_residents / avg_beds end as occupancy_rate,
  case when avg_residents > 0 then avg_total_nurse_hrs / avg_residents end as total_hrs_per_resident,
  case when avg_residents > 0 then avg_rn_hrs / avg_residents end as rn_hrs_per_resident,
  case when avg_residents > 0 then avg_lpn_hrs / avg_residents end as lpn_hrs_per_resident,
  case when avg_residents > 0 then avg_aide_hrs / avg_residents end as aide_hrs_per_resident
from usage
order by month, provider_id
