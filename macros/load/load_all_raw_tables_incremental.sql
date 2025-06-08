{% macro load_all_raw_tables_incremental() %}

    {% do load_health_deficiencies_incremental() %}
    {% do load_state_level_health_inspection_cut_points_incremental() %}
    {% do load_ownership_incremental() %}
    {% do load_penalties_incremental() %}
    {% do load_provider_information_incremental() %}
    {% do load_citation_code_lookup_incremental() %}
    {% do load_covid19_vax_state_national_averages_incremental() %}
    {% do load_covid19_vax_provider_incremental() %}
    {% do load_data_collection_intervals_incremental() %}
    {% do load_fire_safety_deficiencies_incremental() %}
    {% do load_mds_quality_measures_incremental() %}
    {% do load_state_us_averages_incremental() %}
    {% do load_inspection_dates_incremental() %}
    {% do load_survey_summary_incremental() %}
    {% do load_medicare_claims_quality_measures_incremental() %}
    {% do load_fy_2024_snf_vbp_aggregate_performance_incremental() %}
    {% do load_fy_2024_snf_vbp_facility_performance_incremental() %}
    {% do load_snf_quality_reporting_program_national_data_incremental() %}
    {% do load_snf_quality_reporting_program_provider_data_incremental() %}
    {% do load_swing_bed_snf_data_incremental() %}

{% endmacro %}
