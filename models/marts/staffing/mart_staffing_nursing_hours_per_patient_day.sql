{{ config(
    materialized='view',
    tags=['mart', 'profiled']
) }}

SELECT
    provnum,
    provname,
    state,
    workdate,
    Hrs_RN + Hrs_LPN + Hrs_CNA + Hrs_NAtrn + Hrs_Med_Aide as total_nurse_hours,
    mdscensus as total_patient_count,
    total_nurse_hours / total_patient_count as NHPPD 
  FROM {{ ref('stg_daily_nurse_staffing') }}


