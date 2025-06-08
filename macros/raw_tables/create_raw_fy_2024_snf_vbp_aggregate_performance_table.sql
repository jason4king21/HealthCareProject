
{% macro create_raw_fy_2024_snf_vbp_aggregate_performance_table() %}

    {% set sql %}
        CREATE TABLE IF NOT EXISTS HEALTHCARE.RAW.FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE (
    "Baseline Period: FY 2019 National Average Readmission Rate" FLOAT,
    "Performance Period: FY 2022 National Average Readmission Rate" FLOAT,
    "FY 2024 Achievement Threshold" FLOAT,
    "FY 2024 Benchmark" FLOAT,
    "Range of Performance Scores" STRING,
    "Total Number of SNFs Receiving Value-Based Incentive Payments" NUMBER,
    "Range of Incentive Payment Multipliers" STRING,
    "Range of Value-Based Incentive Payments ($)" STRING,
    "Total Amount of Value-Based Incentive Payments ($)" STRING
        );
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}
