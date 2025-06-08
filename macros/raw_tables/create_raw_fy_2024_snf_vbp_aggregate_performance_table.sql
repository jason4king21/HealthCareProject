
{% macro create_raw_fy_2024_snf_vbp_aggregate_performance_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE (
    "Baseline_Period:_FY_2019_National_Average_Readmission_Rate" FLOAT,
    "Performance_Period:_FY_2022_National_Average_Readmission_Rate" FLOAT,
    "FY_2024_Achievement_Threshold" FLOAT,
    "FY_2024_Benchmark" FLOAT,
    "Range_of_Performance_Scores" STRING,
    "Total_Number_of_SNFs_Receiving_Value_Based_Incentive_Payments" NUMBER,
    "Range_of_Incentive_Payment_Multipliers" STRING,
    "Range_of_Value_Based_Incentive_Payments_($)" STRING,
    "Total_Amount_of_Value_Based_Incentive_Payments_($)" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
