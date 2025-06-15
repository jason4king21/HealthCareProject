-- models/mart/top10_throughput.sql


{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}


select
  cms_certification_number_ccn as provider_id,
  provider_name,
  round(avg(average_number_of_residents_per_day),2) as avg_daily_residents
from {{ ref('stg_provider_info') }}
group by 1, provider_name
order by avg_daily_residents desc
limit 10
