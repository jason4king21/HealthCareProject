{% macro create_raw_all_tables() %}

    { create_raw_provider_information_table() }
    { create_raw_state_us_averages_table() }
    { create_raw_data_collection_intervals_table() }
    { create_raw_inspection_dates_table() }
    { create_raw_fire_safety_deficiencies_table() }
    { create_raw_health_deficiencies_table() }
    { create_raw_citation_code_lookup_table() }
    { create_raw_state_level_health_inspection_cut_points_table() }
    { create_raw_survey_summary_table() }
    { create_raw_mds_quality_measures_table() }
    { create_raw_medicare_claims_quality_measures_table() }
    { create_raw_ownership_table() }
    { create_raw_penalties_table() }
    { create_raw_covid19_vax_provider_table() }
    { create_raw_covid19_vax_state_national_averages_table() }

{% endmacro %}
