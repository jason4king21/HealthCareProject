-- models/marts/operational/mart_monthly_nurse_hours.sql

{{ config(materialized="view") }}

with base as (
  select
    PROVNUM         as provider_id,
    PROVNAME        as provider_name,
    STATE           as state,
    try_to_date(WORKDATE) as work_date,  -- single-argument TO_DATE
    HRS_RN + HRS_LPN + HRS_CNA + HRS_NATRN + HRS_MED_AIDE as total_hours
  from {{ ref('stg_daily_nurse_staffing') }}
  where try_to_date(WORKDATE) is not null
),
monthly as (
  select
    provider_id,
    provider_name,
    state,
    date_trunc('month', work_date) as month,
    sum(total_hours) as total_nurse_hours
  from base
  group by 1,2,3,4
)

select
  provider_id,
  provider_name,
  state,
  month,
  to_char(month, 'Mon') as month_name,
  total_nurse_hours
from monthly
order by provider_name, month



