-- models/mart/mart_complaint_ratio.sql
{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

select
  cms_certification_number_ccn as provider_id,
  state,
  avg(number_of_substantiated_complaints) as avg_complaints,
  avg(
    coalesce(Reported_Total_Nurse_Staffing_Hours_per_Resident_per_Day, 0)
    * coalesce(Average_Number_of_Residents_per_Day, 0)
  ) as avg_nurse_hours,
  case 
    when avg_nurse_hours > 0 
      then avg_complaints / avg_nurse_hours 
    else null 
  end as complaints_per_nurse_hour
from {{ ref('stg_provider_info') }}
group by
  cms_certification_number_ccn,
  state
order by
  complaints_per_nurse_hour desc



