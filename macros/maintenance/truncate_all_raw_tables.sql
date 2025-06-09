{% macro truncate_all_raw_tables() %}

    {% set raw_tables = [
        "HEALTH_DEFICIENCIES",
        "STATE_LEVEL_HEALTH_INSPECTION_CUT_POINTS",
        "OWNERSHIP",
        "PENALTIES",
        "PROVIDER_INFORMATION",
        "CITATION_CODE_LOOKUP",
        "COVID19_VAX_STATE_NATIONAL_AVERAGES",
        "COVID19_VAX_PROVIDER",
        "DATA_COLLECTION_INTERVALS",
        "FIRE_SAFETY_DEFICIENCIES",
        "MDS_QUALITY_MEASURES",
        "STATE_US_AVERAGES",
        "INSPECTION_DATES",
        "SURVEY_SUMMARY",
        "MEDICARE_CLAIMS_QUALITY_MEASURES",
        "FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE",
        "FY_2024_SNF_VBP_FACILITY_PERFORMANCE",
        "SNF_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA",
        "SNF_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA",
        "SWING_BED_SNF_DATA",
        "RAW_LOADED_FILES"
    ] %}

    {% for table_name in raw_tables %}

        {% set truncate_sql %}
            TRUNCATE TABLE HEALTHCARE.RAW.{{ table_name }};
        {% endset %}

        {% do log("Truncating table: HEALTHCARE.RAW." ~ table_name, info=True) %}
        {% do run_query(truncate_sql) %}

    {% endfor %}

    {% do log("All RAW tables truncated.", info=True) %}

{% endmacro %}
