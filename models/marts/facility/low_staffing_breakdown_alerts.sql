-- models/mart/low_staffing_breakdown_alerts.sql

{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

with ratios as (
  select
    cms_certification_number_ccn as provider_id,
    provider_name,
    date_trunc('month', ingestion_timestamp)::date as month,
    avg(average_number_of_residents_per_day)                             as avg_residents,
    avg(reported_rn_staffing_hours_per_resident_per_day)                as avg_rn_hrs,
    avg(reported_lpn_staffing_hours_per_resident_per_day)               as avg_lpn_hrs,
    avg(reported_nurse_aide_staffing_hours_per_resident_per_day)        as avg_aide_hrs,
    case when avg(average_number_of_residents_per_day) > 0 
      then avg_rn_hrs   / avg(average_number_of_residents_per_day) end    as rn_hrs_per_resident,
    case when avg(average_number_of_residents_per_day) > 0 
      then avg_lpn_hrs  / avg(average_number_of_residents_per_day) end    as lpn_hrs_per_resident,
    case when avg(average_number_of_residents_per_day) > 0 
      then avg_aide_hrs / avg(average_number_of_residents_per_day) end    as aide_hrs_per_resident
  from {{ ref('stg_provider_info') }}
  group by 1, provider_name, month
)
select
  provider_id,
  provider_name,
  month,
  rn_hrs_per_resident,
  lpn_hrs_per_resident,
  aide_hrs_per_resident
from ratios
where rn_hrs_per_resident is not null
   or lpn_hrs_per_resident is not null
   or aide_hrs_per_resident is not null
order by 
   coalesce(rn_hrs_per_resident, 1e9) asc,
   coalesce(lpn_hrs_per_resident, 1e9) asc,
   coalesce(aide_hrs_per_resident, 1e9) asc
limit 10
