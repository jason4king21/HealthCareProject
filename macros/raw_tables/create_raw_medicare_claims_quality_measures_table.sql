
{% macro create_raw_medicare_claims_quality_measures_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.MEDICARE_CLAIMS_QUALITY_MEASURES (
    "CMS Certification Number (CCN)" STRING,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Measure Code" NUMBER,
    "Measure Description" STRING,
    "Resident type" STRING,
    "Adjusted Score" FLOAT,
    "Observed Score" FLOAT,
    "Expected Score" FLOAT,
    "Footnote for Score" FLOAT,
    "Used in Quality Measure Five Star Rating" STRING,
    "Measure Period" STRING,
    "Location" STRING,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
