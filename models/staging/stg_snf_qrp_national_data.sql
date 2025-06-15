{{ config(materialized='table') }}

select
  "CMS Certification Number (CCN)" as cms_certification_number_ccn,
  "Measure Code" as measure_code,
  "Score" as score,
  cast("Start Date" as date) as start_date,
  cast("End Date" as date) as end_date
from {{ source('RAW', 'SNF_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA') }}
