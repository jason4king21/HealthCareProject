{% macro create_raw_daily_nurse_staffing() %}

  {% set sql %}
    CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.DAILY_NURSE_STAFFING (
      PROVNUM STRING,
      PROVNAME STRING,
      CITY STRING,
      STATE STRING,
      COUNTY_NAME STRING,
      COUNTY_FIPS STRING,
      CY_Qtr STRING,
      WorkDate STRING,
      MDScensus STRING,
      Hrs_RNDON STRING,
      Hrs_RNDON_emp STRING,
      Hrs_RNDON_ctr STRING,
      Hrs_RNadmin STRING,
      Hrs_RNadmin_emp STRING,
      Hrs_RNadmin_ctr STRING,
      Hrs_RN STRING,
      Hrs_RN_emp STRING,
      Hrs_RN_ctr STRING,
      Hrs_LPNadmin STRING,
      Hrs_LPNadmin_emp STRING,
      Hrs_LPNadmin_ctr STRING,
      Hrs_LPN STRING,
      Hrs_LPN_emp STRING,
      Hrs_LPN_ctr STRING,
      Hrs_CNA STRING,
      Hrs_CNA_emp STRING,
      Hrs_CNA_ctr STRING,
      Hrs_NAtrn STRING,
      Hrs_NAtrn_emp STRING,
      Hrs_NAtrn_ctr STRING,
      Hrs_MedAide STRING,
      Hrs_MedAide_emp STRING,
      Hrs_MedAide_ctr STRING
    );
  {% endset %}

  {% do run_query(sql) %}

{% endmacro %}
