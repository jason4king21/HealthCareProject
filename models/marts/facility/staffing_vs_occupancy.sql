-- models/mart/staffing_vs_occupancy.sql


{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}


with usage as (
  select
    cms_certification_number_ccn as provider_id,
    date_trunc('month', ingestion_timestamp)::date as month,
    avg(average_number_of_residents_per_day) as avg_residents,
    avg(number_of_certified_beds) as avg_beds,
    avg(reported_total_nurse_staffing_hours_per_resident_per_day) as avg_nurse_hrs
  from {{ ref('stg_provider_info') }}
  group by 1, month
)
select
  month,
  provider_id,
  avg_residents,
  avg_beds,
  avg_nurse_hrs,
  case
    when avg_beds > 0
      then avg_residents / avg_beds
    else null
  end as occupancy_rate
from usage
order by month, provider_id
