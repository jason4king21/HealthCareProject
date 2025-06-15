-- models/mart/mart_staffing_readmission_correlation_by_state.sql
{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

with staffing as (
  select
    s.provider_id,
    prov.state,
    s.nurse_hrs_per_resident_day
  from {{ ref('stg_staffing_agg') }} s
  join {{ ref('stg_provider_info') }} prov
    on s.provider_id = prov.cms_certification_number_ccn
),
readmit as (
  select
    cms_certification_number_ccn as provider_id,
    performance_readmission_rate as readmission_rate
  from {{ ref('stg_snf_vbp_performance') }}
)
select
  staffing.state,
  corr(staffing.nurse_hrs_per_resident_day, readmit.readmission_rate) as pearson_corr,
  count(*) as observations
from staffing
join readmit using (provider_id)
where staffing.nurse_hrs_per_resident_day is not null
  and readmit.readmission_rate is not null
group by staffing.state
order by staffing.state
