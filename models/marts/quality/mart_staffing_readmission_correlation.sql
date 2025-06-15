-- models/mart/mart_staffing_readmission_correlation.sql
{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

with staffing as (
  select
    provider_id,
    nurse_hrs_per_resident_day
  from {{ ref('stg_staffing_agg') }}
),
readmit as (
  select
    cms_certification_number_ccn as provider_id,
    performance_readmission_rate as readmission_rate
  from {{ ref('stg_snf_vbp_performance') }}
  where performance_readmission_rate is not null
)
select
  corr(staffing.nurse_hrs_per_resident_day, readmission_rate) as pearson_corr,
  count(*) as observations
from staffing
join readmit using (provider_id)
where staffing.nurse_hrs_per_resident_day is not null
  and readmission_rate is not null
