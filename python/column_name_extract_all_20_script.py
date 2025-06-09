
# FINAL COLUMN NAME EXTRACT ALL 20 SCRIPT

import snowflake.connector

# Configurable parameters
SNOWFLAKE_USER = 'PC_DBT_USER'
SNOWFLAKE_PASSWORD = 'ThreeKings21@1234'
SNOWFLAKE_ACCOUNT = 'BWPLKWD-SR59008'
SNOWFLAKE_WAREHOUSE = 'COMPUTE_WH'
SNOWFLAKE_DATABASE = 'HEALTHCARE'
SNOWFLAKE_SCHEMA = 'RAW'

# List of 20 RAW tables
raw_tables_20 = [
    "HEALTH_DEFICIENCIES",
    "STATE_LEVEL_HEALTH_INSPECTION_CUT_POINTS",
    "OWNERSHIP",
    "PENALTIES",
    "PROVIDER_INFORMATION",
    "CITATION_CODE_LOOKUP",
    "COVID19_VAX_STATE_NATIONAL_AVERAGES",
    "COVID19_VAX_PROVIDER",
    "DATA_COLLECTION_INTERVALS",
    "FIRE_SAFETY_DEFICIENCIES",
    "MDS_QUALITY_MEASURES",
    "STATE_US_AVERAGES",
    "INSPECTION_DATES",
    "SURVEY_SUMMARY",
    "MEDICARE_CLAIMS_QUALITY_MEASURES",
    "FY_2024_SNF_VBP_AGGREGATE_PERFORMANCE",
    "FY_2024_SNF_VBP_FACILITY_PERFORMANCE",
    "SNF_QUALITY_REPORTING_PROGRAM_NATIONAL_DATA",
    "SNF_QUALITY_REPORTING_PROGRAM_PROVIDER_DATA",
    "SWING_BED_SNF_DATA"
]

# Connect to Snowflake
conn = snowflake.connector.connect(
    user=SNOWFLAKE_USER,
    password=SNOWFLAKE_PASSWORD,
    account=SNOWFLAKE_ACCOUNT,
    warehouse=SNOWFLAKE_WAREHOUSE,
    database=SNOWFLAKE_DATABASE,
    schema=SNOWFLAKE_SCHEMA
)

# Function to extract column names
def extract_column_names(table_name):
    query = f"""
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = '{SNOWFLAKE_SCHEMA}'
          AND TABLE_CATALOG = '{SNOWFLAKE_DATABASE}'
          AND TABLE_NAME = UPPER('{table_name}')
        ORDER BY ORDINAL_POSITION
    """
    cur = conn.cursor()
    cur.execute(query)
    results = cur.fetchall()
    column_names = [row[0] for row in results]
    cur.close()
    return column_names

# Process all 20 tables
for table_name in raw_tables_20:
    print(f"\n==============================")
    print(f"Table: {table_name}")
    print(f"==============================\n")
    column_names = extract_column_names(table_name)
    print("{% set column_names = [")
    for col in column_names:
        print(f"    '{col}',")
    print("] %}")
    print("\n")

# Close connection
conn.close()
