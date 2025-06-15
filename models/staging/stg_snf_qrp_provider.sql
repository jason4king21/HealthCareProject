{{ config(materialized='table') }}

select
  cast(CCN as varchar) as cms_certification_number_ccn,
  QRP_Measure_ID as measure_id,
  QRP_Measure_Description as measure_name,
  cast(QRP_Percent as float) as measure_result,
  reporting_period_start,
  reporting_period_end
from {{ source('RAW', 'SNF_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA') }}
