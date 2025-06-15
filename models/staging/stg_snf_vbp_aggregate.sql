{{ config(materialized='table') }}

select
  "Baseline Period: FY 2019 National Average Readmission Rate" as baseline_readmission_rate,
  "Performance Period: FY 2022 National Average Readmission Rate" as national_readmission_rate,
  "FY 2024 Achievement Threshold" as achievement_threshold,
  "FY 2024 Benchmark" as benchmark,
  "Total Number of SNFs Receiving Value-Based Incentive Payments" as number_of_snfs
from {{ source('RAW', 'FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE') }}

