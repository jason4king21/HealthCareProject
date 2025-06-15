{{ config(materialized='table') }}

with raw as (
  select
    to_char("CMS Certification Number (CCN)") as cms_certification_number_ccn,
    "Performance Period: FY 2022 Risk-Standardized Readmission Rate" as performance_readmission_rate,
    "Incentive Payment Multiplier" as incentive_multiplier,
    "Achievement Score" as achievement_score,
    "Improvement Score" as improvement_score,
    "Performance Score" as performance_score,
    "Provider Name" as provider_name,
    "City/Town" as city,
    "State" as state,
    try_cast("ZIP Code" as integer) as zip_code
  from {{ source('RAW', 'FY_2024_SNF_VBP_FACILITY_PERFORMANCE') }}
)
select * from raw
