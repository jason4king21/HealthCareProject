
{% macro create_raw_fy_2024_snf_vbp_facility_performance_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.FY_2024_SNF_VBP_FACILITY_PERFORMANCE (
    "SNF VBP Program Ranking" NUMBER,
    "Footnote -- SNF VBP Program Ranking" FLOAT,
    "CMS Certification Number (CCN)" NUMBER,
    "Provider Name" STRING,
    "Provider Address" STRING,
    "City/Town" STRING,
    "State" STRING,
    "ZIP Code" NUMBER,
    "Baseline Period: FY 2019 Risk-Standardized Readmission Rate" STRING,
    "Footnote -- Baseline Period: FY 2019 Risk-Standardized Readmission Rate" STRING,
    "Performance Period: FY 2022 Risk-Standardized Readmission Rate" FLOAT,
    "Footnote -- Performance Period: FY 2022 Risk-Standardized Readmission Rate" FLOAT,
    "Achievement Score" FLOAT,
    "Footnote -- Achievement Score" FLOAT,
    "Improvement Score" STRING,
    "Footnote -- Improvement Score" STRING,
    "Performance Score" FLOAT,
    "Footnote -- Performance Score" FLOAT,
    "Incentive Payment Multiplier" FLOAT,
    "Footnote -- Incentive Payment Multiplier" FLOAT
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
