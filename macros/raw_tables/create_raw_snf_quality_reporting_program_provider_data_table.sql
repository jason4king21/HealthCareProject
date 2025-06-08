
{% macro create_raw_snf_quality_reporting_program_provider_data_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SNF_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA (
    "CMS Certification Number (CCN)" NUMBER,
    "Provider Name" STRING,
    "Address Line 1" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "County/Parish" STRING,
    "Telephone Number" STRING,
    "CMS Region" NUMBER,
    "Measure Code" STRING,
    "Score" STRING,
    "Footnote" STRING,
    "Start Date" STRING,
    "End Date" STRING,
    "Measure Date Range" STRING,
    "LOCATION1" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
