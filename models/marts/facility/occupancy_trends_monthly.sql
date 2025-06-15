-- models/mart/occupancy_trends_monthly.sql

{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

with base as (
  select
    date_trunc('month', ingestion_timestamp)::date as month,
    cms_certification_number_ccn as provider_id,
    avg(average_number_of_residents_per_day) as avg_residents,
    avg(number_of_certified_beds) as avg_certified_beds
  from {{ ref('stg_provider_info') }}
  where average_number_of_residents_per_day is not null
    and number_of_certified_beds is not null
  group by 1, provider_id
)
select
  month,
  provider_id,
  avg_residents,
  avg_certified_beds,
  case
    when avg_certified_beds > 0
      then avg_residents / avg_certified_beds
    else null
  end as occupancy_rate
from base
order by month
