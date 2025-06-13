{{ config(
    materialized='table',
    tags=['silver', 'profiled']
) }}

with source as (
    select * from {{ source('source', 'daily_nurse_staffing') }}
),

casted as (

  select
    provnum,
    nullif(provname,'') as provname,
    city,
    state,
    county_name,
    county_fips,
    cy_qtr,
    to_date(workdate, 'YYYYMMDD') as workdate,
    mdscensus::int    as mdscensus,
    hrs_rndon::numeric    as hrs_rndon,
    hrs_rndon_emp::numeric as hrs_rndon_emp,
    hrs_rndon_ctr::numeric as hrs_rndon_ctr,
    hrs_rnadmin::numeric    as hrs_rnadmin,
    hrs_rnadmin_emp::numeric as hrs_rnadmin_emp,
    hrs_rnadmin_ctr::numeric as hrs_rnadmin_ctr,
    hrs_rn::numeric         as hrs_rn,
    hrs_rn_emp::numeric     as hrs_rn_emp,
    hrs_rn_ctr::numeric     as hrs_rn_ctr,
    hrs_lpnadmin::numeric    as hrs_lpnadmin,
    hrs_lpnadmin_emp::numeric as hrs_lpnadmin_emp,
    hrs_lpnadmin_ctr::numeric as hrs_lpnadmin_ctr,
    hrs_lpn::numeric         as hrs_lpn,
    hrs_lpn_emp::numeric     as hrs_lpn_emp,
    hrs_lpn_ctr::numeric     as hrs_lpn_ctr,
    hrs_cna::numeric         as hrs_cna,
    hrs_cna_emp::numeric     as hrs_cna_emp,
    hrs_cna_ctr::numeric     as hrs_cna_ctr,
    hrs_natrn::numeric      as hrs_natrn,
    hrs_natrn_emp::numeric  as hrs_natrn_emp,
    hrs_natrn_ctr::numeric  as hrs_natrn_ctr,
    hrs_med_aide::numeric   as hrs_med_aide,
    hrs_med_aide_emp::numeric as hrs_med_aide_emp,
    hrs_med_aide_ctr::numeric as hrs_med_aide_ctr

  from source

),

cleaned as (
    select
      *,
      trim(provname) as provname_trimmed,
      case when provnum is null then 'UNKNOWN' else provnum end as provnum_filled
    from casted
    WHERE 1=1
        AND State IN ('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
        AND workdate is not null
)

select * from cleaned