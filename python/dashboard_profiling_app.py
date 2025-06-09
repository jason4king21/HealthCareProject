
# FINAL DASHBOARD PROFILING APP FOR 20 TABLES

import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import snowflake.connector

# Configurable parameters
SNOWFLAKE_USER = 'PC_DBT_USER'
SNOWFLAKE_PASSWORD = 'ThreeKings21@1234'
SNOWFLAKE_ACCOUNT = 'BWPLKWD-SR59008'
SNOWFLAKE_WAREHOUSE = 'COMPUTE_WH'
SNOWFLAKE_DATABASE = 'HEALTHCARE'
SNOWFLAKE_SCHEMA = 'RAW'

# Connect to Snowflake
@st.cache_resource
def get_connection():
    conn = snowflake.connector.connect(
        user=SNOWFLAKE_USER,
        password=SNOWFLAKE_PASSWORD,
        account=SNOWFLAKE_ACCOUNT,
        warehouse=SNOWFLAKE_WAREHOUSE,
        database=SNOWFLAKE_DATABASE,
        schema=SNOWFLAKE_SCHEMA
    )
    return conn

# Load table
@st.cache_data
def load_table(table_name):
    query = f"""SELECT * FROM {SNOWFLAKE_DATABASE}.{SNOWFLAKE_SCHEMA}.{table_name};"""
    df = pd.read_sql(query, conn)
    return df

# Initialize connection
conn = get_connection()

# List of tables
table_names = ['health_deficiencies', 'state_level_health_inspection_cut_points', 'ownership', 'penalties', 'provider_information', 'citation_code_lookup', 'covid19_vax_state_national_averages', 'covid19_vax_provider', 'data_collection_intervals', 'fire_safety_deficiencies', 'mds_quality_measures', 'state_us_averages', 'inspection_dates', 'survey_summary', 'medicare_claims_quality_measures', 'fy_2024_snf_vbp_aggregate_performance', 'fy_2024_snf_vbp_facility_performance', 'snf_quality_reporting_program_national_data', 'snf_quality_reporting_program_provider_data', 'swing_bed_snf_data']

# Streamlit app
st.title("📊 RAW Layer Data Profiling Dashboard")
st.sidebar.header("Select Table")

selected_table = st.sidebar.selectbox("Choose a table to profile:", table_names)
df = load_table(selected_table.upper())

st.header(f"Data Preview - {selected_table}")
st.write(df.head())

# Row count
st.subheader("Row Count")
st.write(len(df))

# Missing values
st.subheader("Missing Values per Column")
missing_counts = df.isnull().sum()
missing_percent = (df.isnull().sum() / len(df)) * 100
missing_df = pd.DataFrame({
    "Missing Count": missing_counts,
    "Missing %": missing_percent
})
st.write(missing_df)

# Plot missing values
missing_counts_plot = missing_counts[missing_counts > 0]
if not missing_counts_plot.empty:
    fig, ax = plt.subplots(figsize=(10,6))
    sns.barplot(x=missing_counts_plot.index, y=missing_counts_plot.values, ax=ax)
    ax.set_title(f"Missing Values per Column - {{selected_table}}")
    ax.set_ylabel("Number of Missing Values")
    ax.set_xticklabels(ax.get_xticklabels(), rotation=45, ha='right')
    st.pyplot(fig)
else:
    st.write("✅ No missing values to plot.")

# Duplicate rows
st.subheader("Duplicate Rows")
duplicates_count = df.duplicated().sum()
st.write(f"Number of duplicate rows: {{duplicates_count}}")

# Outliers (Z-Score > 3)
st.subheader("Outliers (Z-Score > 3 on numeric columns)")
numeric_cols = df.select_dtypes(include=[np.number]).columns.tolist()
outlier_counts = {}
for col in numeric_cols:
    z_scores = np.abs((df[col] - df[col].mean()) / df[col].std())
    outliers = (z_scores > 3).sum()
    outlier_counts[col] = outliers

outlier_df = pd.DataFrame.from_dict(outlier_counts, orient='index', columns=['Outlier Count'])
st.write(outlier_df)

st.success("Profiling complete for selected table.")
