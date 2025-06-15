-- mart_perm_vs_contract_ratio.sql
select
  PROVNUM as provider_id,
  STATE as state,
  sum(HRS_RN + HRS_LPN + HRS_CNA) as perm_hours,
  sum(HRS_RN_ctr + HRS_LPN_ctr + HRS_CNA_ctr) as contract_hours,
  case
    when perm_hours + contract_hours > 0
      then perm_hours / (perm_hours + contract_hours)
    else null
  end as pct_permanent_staff
from {{ ref('stg_daily_nurse_staffing') }}
group by provider_id, state
