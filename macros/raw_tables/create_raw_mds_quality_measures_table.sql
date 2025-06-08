
{% macro create_raw_mds_quality_measures_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.MDS_QUALITY_MEASURES (
    "CMS Certification Number (CCN)" NUMBER,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Measure Code" NUMBER,
    "Measure Description" STRING,
    "Resident type" STRING,
    "Q1 Measure Score" FLOAT,
    "Footnote for Q1 Measure Score" FLOAT,
    "Q2 Measure Score" FLOAT,
    "Footnote for Q2 Measure Score" FLOAT,
    "Q3 Measure Score" FLOAT,
    "Footnote for Q3 Measure Score" FLOAT,
    "Q4 Measure Score" FLOAT,
    "Footnote for Q4 Measure Score" FLOAT,
    "Four Quarter Average Score" FLOAT,
    "Footnote for Four Quarter Average Score" FLOAT,
    "Used in Quality Measure Five Star Rating" STRING,
    "Measure Period" STRING,
    "Location" STRING,
    "Processing Date" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
