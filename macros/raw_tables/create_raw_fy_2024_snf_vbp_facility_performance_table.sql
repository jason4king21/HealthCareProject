
{% macro create_raw_fy_2024_snf_vbp_facility_performance_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.FY_2024_SNF_VBP_FACILITY_PERFORMANCE (
    "SNF_VBP_Program_Ranking" NUMBER,
    "Footnote____SNF_VBP_Program_Ranking" FLOAT,
    "CMS_Certification_Number_(CCN)" NUMBER,
    "Provider_Name" STRING,
    "Provider_Address" STRING,
    "City_Town" STRING,
    "State" STRING,
    "ZIP_Code" NUMBER,
    "Baseline_Period:_FY_2019_Risk_Standardized_Readmission_Rate" STRING,
    "Footnote____Baseline_Period:_FY_2019_Risk_Standardized_Readmission_Rate" STRING,
    "Performance_Period:_FY_2022_Risk_Standardized_Readmission_Rate" FLOAT,
    "Footnote____Performance_Period:_FY_2022_Risk_Standardized_Readmission_Rate" FLOAT,
    "Achievement_Score" FLOAT,
    "Footnote____Achievement_Score" FLOAT,
    "Improvement_Score" STRING,
    "Footnote____Improvement_Score" STRING,
    "Performance_Score" FLOAT,
    "Footnote____Performance_Score" FLOAT,
    "Incentive_Payment_Multiplier" FLOAT,
    "Footnote____Incentive_Payment_Multiplier" FLOAT
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
