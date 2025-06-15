{{ config(
    materialized='table',
    tags=['silver', 'profiled']
) }}

with source as (
    select * from {{ source('RAW', 'daily_nurse_staffing') }}
),

casted as (
  select
    provnum,
    nullif(provname, '') as provname,
    city,
    state,
    county_name,
    county_fips,
    cy_qtr,
    to_date(workdate, 'YYYYMMDD') as workdate,
    coalesce(mdscensus::int, 0)                      as mdscensus,
    coalesce(hrs_rndon::numeric, 0)                  as hrs_rndon,
    coalesce(hrs_rndon_emp::numeric, 0)              as hrs_rndon_emp,
    coalesce(hrs_rndon_ctr::numeric, 0)              as hrs_rndon_ctr,
    coalesce(hrs_rnadmin::numeric, 0)                as hrs_rnadmin,
    coalesce(hrs_rnadmin_emp::numeric, 0)            as hrs_rnadmin_emp,
    coalesce(hrs_rnadmin_ctr::numeric, 0)            as hrs_rnadmin_ctr,
    coalesce(hrs_rn::numeric, 0)                     as hrs_rn,
    coalesce(hrs_rn_emp::numeric, 0)                 as hrs_rn_emp,
    coalesce(hrs_rn_ctr::numeric, 0)                 as hrs_rn_ctr,
    coalesce(hrs_lpnadmin::numeric, 0)               as hrs_lpnadmin,
    coalesce(hrs_lpnadmin_emp::numeric, 0)           as hrs_lpnadmin_emp,
    coalesce(hrs_lpnadmin_ctr::numeric, 0)           as hrs_lpnadmin_ctr,
    coalesce(hrs_lpn::numeric, 0)                    as hrs_lpn,
    coalesce(hrs_lpn_emp::numeric, 0)                as hrs_lpn_emp,
    coalesce(hrs_lpn_ctr::numeric, 0)                as hrs_lpn_ctr,
    coalesce(hrs_cna::numeric, 0)                    as hrs_cna,
    coalesce(hrs_cna_emp::numeric, 0)                as hrs_cna_emp,
    coalesce(hrs_cna_ctr::numeric, 0)                as hrs_cna_ctr,
    coalesce(hrs_natrn::numeric, 0)                  as hrs_natrn,
    coalesce(hrs_natrn_emp::numeric, 0)              as hrs_natrn_emp,
    coalesce(hrs_natrn_ctr::numeric, 0)              as hrs_natrn_ctr,
    coalesce(hrs_med_aide::numeric, 0)               as hrs_med_aide,
    coalesce(hrs_med_aide_emp::numeric, 0)           as hrs_med_aide_emp,
    coalesce(hrs_med_aide_ctr::numeric, 0)           as hrs_med_aide_ctr
  from source
),

cleaned as (
  select
    *,
    trim(provname) as provname_trimmed,
    coalesce(provnum, 'UNKNOWN') as provnum_filled
  from casted
  where state in (
    'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA',
    'KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',
    'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
    'VA','WA','WV','WI','WY'
  )
  and workdate is not null
)

select * from cleaned
