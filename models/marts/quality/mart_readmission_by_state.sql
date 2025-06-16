{{ config(materialized='view', schema='MARTS', alias='mart_readmission_by_state') }}

with base as (
  select
    state_or_nation                                 as state,
    pct_shortstay_rehospitalized                    as rehospitalization_pct,
    pct_shortstay_ed_visit                          as ed_visit_pct,
    hosp_per_1000_longstay_resident_days            as hosp_per_1k_days,
    ed_per_1000_longstay_resident_days              as ed_visits_per_1k_days
  from {{ ref('stg_state_us_averages') }}
  where state_or_nation is not null
)

select
  state,
  rehospitalization_pct,
  ed_visit_pct,
  hosp_per_1k_days,
  ed_visits_per_1k_days
from base
order by state
