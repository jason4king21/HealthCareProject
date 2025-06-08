{% macro create_all_raw_tables() %}

    {% do create_raw_provider_information_table() %}
    {% do create_raw_state_us_averages_table() %}
    {% do create_raw_data_collection_intervals_table() %}
    {% do create_raw_inspection_dates_table() %}
    {% do create_raw_fire_safety_deficiencies_table() %}
    {% do create_raw_health_deficiencies_table() %}
    {% do create_raw_citation_code_lookup_table() %}
    {% do create_raw_state_level_health_inspection_cut_points_table() %}
    {% do create_raw_survey_summary_table() %}
    {% do create_raw_mds_quality_measures_table() %}
    {% do create_raw_medicare_claims_quality_measures_table() %}
    {% do create_raw_ownership_table() %}
    {% do create_raw_penalties_table() %}
    {% do create_raw_covid19_vax_provider_table() %}
    {% do create_raw_covid19_vax_state_national_averages_table() %}
    {% do create_raw_fy_2024_snf_vbp_aggregate_performance_table() %}
    {% do create_raw_fy_2024_snf_vbp_facility_performance_table() %}
    {% do create_raw_snf_quality_reporting_program_national_data_table() %}
    {% do create_raw_snf_quality_reporting_program_provider_data_table() %}
    {% do create_raw_swing_bed_snf_data_table() %}

{% endmacro %}
