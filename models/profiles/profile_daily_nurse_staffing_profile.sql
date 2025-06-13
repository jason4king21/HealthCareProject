-- models/profiles/profile_daily_nurse_staffing_profile.sql

{{ config(
    materialized = "table",
    schema = "profiles",
    alias = "daily_nurse_staffing_profile"
) }}

{% if execute %}
  {{ dbt_profiler.get_profile(relation=source('healthcare_raw', 'DAILY_NURSE_STAFFING')) }}
{% endif %}
