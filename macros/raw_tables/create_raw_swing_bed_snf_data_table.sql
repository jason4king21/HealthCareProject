
{% macro create_raw_swing_bed_snf_data_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.SWING_BED_SNF_DATA (
    "CMS Certification Number (CCN)" STRING,
    "Provider Name" STRING,
    "Address Line 1" STRING,
    "Address Line 2" STRING,
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
    "MeasureDateRange" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
