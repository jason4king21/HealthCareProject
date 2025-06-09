📊 Data Profiling Layer — Healthcare Project
Overview
This Profiling Layer provides automated Data Quality Monitoring for the HEALTHCARE.RAW tables.

✅ It was fully generated from the official CMS Healthcare Data Dictionary + CSV headers.
✅ All models use safe aliasing and no trailing commas → 100% dbt and Snowflake compliant.
✅ The models are fully incremental and optimized.

Architecture
Each table in HEALTHCARE.RAW has a corresponding profiling model:

models/monitoring/profile_<table_name>_tracking.sql

Each profiling model performs:

Row count check

Null count check per column

Standardized output:

table_name

run_date

row_count

<column>_null_count for every column in the table

Current Tables Profiled (20)
Table
HEALTH_DEFICIENCIES
STATE_LEVEL_HEALTH_INSPECTION_CUT_POINTS
OWNERSHIP
PENALTIES
PROVIDER_INFORMATION
CITATION_CODE_LOOKUP
COVID19_VAX_STATE_NATIONAL_AVERAGES
COVID19_VAX_PROVIDER
DATA_COLLECTION_INTERVALS
FIRE_SAFETY_DEFICIENCIES
MDS_QUALITY_MEASURES
STATE_US_AVERAGES
INSPECTION_DATES
SURVEY_SUMMARY
MEDICARE_CLAIMS_QUALITY_MEASURES
FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE
FY_2024_SNF_VBP_FACILITY_PERFORMANCE
SNF_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA
SNF_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA
SWING_BED_SNF_DATA

How to run
bash
Copy
Edit
dbt run --select path:models/monitoring
All profiling models will run in parallel.

You can schedule this as a dbt Cloud Job → to monitor your data daily / weekly.

Why this matters
Automated Data Quality Monitoring is critical in a modern Data Platform.

By running this layer:

You detect missing values trends over time.

You track record volume anomalies.

You can alert on schema changes.

You maintain transparency with data consumers.

Future Improvements
✅ Add deduplication checks
✅ Add outlier checks
✅ Add distribution profiling (e.g. top values, min/max per column)
✅ Load results to a central tracking table → for dashboards in Looker, Power BI, Streamlit.

Credits
This profiling layer was generated automatically from:

✅ CMS Healthcare Data Dictionary
✅ CSV file headers from official CMS data sources
✅ Automated with Python + dbt macro templates.


