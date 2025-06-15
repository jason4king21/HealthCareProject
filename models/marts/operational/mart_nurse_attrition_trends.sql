-- mart_nurse_attrition_trends.sql
select
  CMS_Certification_Number_CCN as provider_id,
  state,
  processing_date as as_of_date,
  total_nursing_staff_turnover,
  registered_nurse_turnover
from {{ ref('stg_provider_info') }}
where total_nursing_staff_turnover is not null
order by provider_id, as_of_date
