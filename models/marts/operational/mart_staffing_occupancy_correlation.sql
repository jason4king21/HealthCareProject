-- models/marts/operational/mart_staffing_occupancy_correlation.sql
with staffing as (
  select
    provider_id,
    workdate,
    total_hrs_per_resident as staff_intensity
  from {{ ref('mart_daily_staffing_intensity') }}
),
occupancy as (
  select
    cms_certification_number_ccn as provider_id,
    processing_date::date as workdate,
    average_number_of_residents_per_day
      / nullif(number_of_certified_beds, 0) as occupancy_rate
  from {{ ref('stg_provider_info') }}
),
joined as (
  select
    s.provider_id,
    s.workdate,
    s.staff_intensity,
    o.occupancy_rate
  from staffing s
  join occupancy o using (provider_id, workdate)
  where s.staff_intensity is not null
    and o.occupancy_rate is not null
)
select
  provider_id,
  corr(staff_intensity, occupancy_rate) as pearson_corr,
  count(*) as observation_days,
  avg(staff_intensity) as avg_staff_intensity,
  avg(occupancy_rate) as avg_occupancy_rate
from joined
group by provider_id

union all

select
  'ALL' as provider_id,
  corr(staff_intensity, occupancy_rate) as pearson_corr,
  count(*) as observation_days,
  avg(staff_intensity) as avg_staff_intensity,
  avg(occupancy_rate) as avg_occupancy_rate
from joined
