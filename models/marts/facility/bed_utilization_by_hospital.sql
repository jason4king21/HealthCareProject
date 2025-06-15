-- models/mart/bed_utilization_by_hospital.sql

{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

select
  date_trunc('month', ingestion_timestamp)::date as month,
  cms_certification_number_ccn as provider_id,
  provider_name,
  sum(average_number_of_residents_per_day) as total_avg_residents,
  sum(number_of_certified_beds) as total_certified_beds,
  case
    when sum(number_of_certified_beds) > 0
      then sum(average_number_of_residents_per_day) / sum(number_of_certified_beds)
    else null
  end as utilization_rate
from {{ ref('stg_provider_info') }}
group by 1, provider_id, provider_name
order by utilization_rate desc
