-- models/mart/mart_readmission_rates.sql
{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

select
  p.cms_certification_number_ccn as provider_id,
  prov.state,
  p.performance_readmission_rate as readmission_rate
from {{ ref('stg_snf_vbp_performance') }} p
join (
  select distinct cms_certification_number_ccn, state
  from {{ ref('stg_provider_info') }}
) prov
  on p.cms_certification_number_ccn = prov.cms_certification_number_ccn
where p.performance_readmission_rate is not null
order by prov.state, provider_id

