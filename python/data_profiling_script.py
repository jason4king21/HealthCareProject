
# FINAL DATA PROFILING SCRIPT FOR 20 TABLES

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import snowflake.connector
import os

# Configurable parameters
SNOWFLAKE_USER = 'PC_DBT_USER'
SNOWFLAKE_PASSWORD = 'ThreeKings21@1234'
SNOWFLAKE_ACCOUNT = 'BWPLKWD-SR59008'
SNOWFLAKE_WAREHOUSE = 'COMPUTE_WH'
SNOWFLAKE_DATABASE = 'HEALTHCARE'
SNOWFLAKE_SCHEMA = 'RAW'

# Connect to Snowflake
conn = snowflake.connector.connect(
    user=SNOWFLAKE_USER,
    password=SNOWFLAKE_PASSWORD,
    account=SNOWFLAKE_ACCOUNT,
    warehouse=SNOWFLAKE_WAREHOUSE,
    database=SNOWFLAKE_DATABASE,
    schema=SNOWFLAKE_SCHEMA
)

# Function to load table
def load_table(table_name):
    query = f"SELECT * FROM {SNOWFLAKE_DATABASE}.{SNOWFLAKE_SCHEMA}.{table_name};"
    df = pd.read_sql(query, conn)
    print(f"Loaded {len(df)} rows from {table_name}")
    return df

# Prepare output folders
os.makedirs("profiling_reports", exist_ok=True)
os.makedirs("profiling_reports/missing_values_plots", exist_ok=True)

# Initialize summary dataframe
summary_rows = []

# List of tables
table_names = ['health_deficiencies', 'state_level_health_inspection_cut_points', 'ownership', 'penalties', 'provider_information', 'citation_code_lookup', 'covid19_vax_state_national_averages', 'covid19_vax_provider', 'data_collection_intervals', 'fire_safety_deficiencies', 'mds_quality_measures', 'state_us_averages', 'inspection_dates', 'survey_summary', 'medicare_claims_quality_measures', 'fy_2024_snf_vbp_aggregate_performance', 'fy_2024_snf_vbp_facility_performance', 'snf_quality_reporting_program_national_data', 'snf_quality_reporting_program_provider_data', 'swing_bed_snf_data']

# Process each table
for table_name in table_names:
    print(f"\nProcessing table: {table_name}")
    df = load_table(table_name.upper())

    # 1️⃣ Missing Values Report
    missing_counts = df.isnull().sum()
    missing_percent = (df.isnull().sum() / len(df)) * 100

    # 2️⃣ Duplicates
    duplicates_count = df.duplicated().sum()

    # 3️⃣ Outliers (Z-Score > 3 on numeric columns)
    numeric_cols = df.select_dtypes(include=[np.number]).columns.tolist()
    outlier_counts = {}
    for col in numeric_cols:
        z_scores = np.abs((df[col] - df[col].mean()) / df[col].std())
        outliers = (z_scores > 3).sum()
        outlier_counts[col] = outliers

    # Save summary row
    summary_rows.append({
        "Table": table_name,
        "RowCount": len(df),
        "DuplicateRows": duplicates_count,
        "ColumnsWithMissing": (missing_counts > 0).sum(),
        "TotalMissingValues": missing_counts.sum(),
        "OutliersFound": sum(outlier_counts.values())
    })

    # 4️⃣ Visualization: Missing Values Histogram
    missing_counts_plot = missing_counts[missing_counts > 0]

    if not missing_counts_plot.empty:
        plt.figure(figsize=(10,6))
        sns.barplot(x=missing_counts_plot.index, y=missing_counts_plot.values)
        plt.title(f"Missing Values per Column - {table_name}")
        plt.ylabel("Number of Missing Values")
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        plot_path = f"profiling_reports/missing_values_plots/{table_name}_missing_values.png"
        plt.savefig(plot_path)
        plt.close()
        print(f"Saved missing values plot to {plot_path}")
    else:
        print("No missing values to plot.")

# Save summary CSV
summary_df = pd.DataFrame(summary_rows)
summary_csv_path = "profiling_reports/profiling_summary.csv"
summary_df.to_csv(summary_csv_path, index=False)
print(f"\nSaved profiling summary to {summary_csv_path}")

# Close connection
conn.close()
print("\nData profiling complete!")
