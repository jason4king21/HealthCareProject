-- models/mart/low_staffing_alerts.sql

{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

with ratios as (
  select
    cms_certification_number_ccn as provider_id,
    provider_name,
    date_trunc('month', ingestion_timestamp)::date as month,
    avg(average_number_of_residents_per_day) as avg_residents,
    avg(reported_total_nurse_staffing_hours_per_resident_per_day) as avg_nurse_hrs,
    case
      when avg(average_number_of_residents_per_day) > 0
        then avg_nurse_hrs / avg_residents
      else null
    end as hrs_per_resident
  from {{ ref('stg_provider_info') }}
  group by 1, provider_name, month
)
select
  *
from ratios
where hrs_per_resident is not null
order by hrs_per_resident asc
limit 10
