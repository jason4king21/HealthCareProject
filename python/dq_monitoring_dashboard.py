# dq_monitoring_dashboard.py

import streamlit as st
import pandas as pd
import snowflake.connector
import plotly.express as px

# Configurable parameters
SNOWFLAKE_USER = 'PC_DBT_USER'
SNOWFLAKE_PASSWORD = 'ThreeKings21@1234'
SNOWFLAKE_ACCOUNT = 'BWPLKWD-SR59008'
SNOWFLAKE_WAREHOUSE = 'COMPUTE_WH'
SNOWFLAKE_DATABASE = 'HEALTHCARE'
SNOWFLAKE_SCHEMA = 'RAW'

# --- CONNECTION ---
def get_snowflake_connection():
# Connect to Snowflake
    conn = snowflake.connector.connect(
        user=SNOWFLAKE_USER,
        password=SNOWFLAKE_PASSWORD,
        account=SNOWFLAKE_ACCOUNT,
        warehouse=SNOWFLAKE_WAREHOUSE,
        database=SNOWFLAKE_DATABASE,
        schema=SNOWFLAKE_SCHEMA
    )
    return conn

# --- LOAD PROFILE TABLES ---
def get_profile_tables(conn):
    query = """
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'MONITORING'
      AND table_name LIKE 'PROFILE\_%\_TRACKING'
    ORDER BY table_name
    """
    df = pd.read_sql(query, conn)
    return df['TABLE_NAME'].tolist()

# --- LOAD PROFILE DATA ---
def load_profile_data(conn, table_name):
    query = f"""
    SELECT *
    FROM MONITORING.{table_name}
    ORDER BY run_date DESC
    """
    df = pd.read_sql(query, conn)
    return df

# --- MAIN STREAMLIT APP ---
def main():
    st.set_page_config(page_title="Healthcare Data Quality Monitoring", layout="wide")
    st.title("\U0001F4CA Healthcare Data Quality Monitoring Dashboard")

    with st.sidebar:
        st.header("\U0001F5C3 Profile Tables")

        # Connect to Snowflake
        conn = get_snowflake_connection()

        # Load list of profile tables
        profile_tables = get_profile_tables(conn)

        selected_table = st.selectbox("Select a profile table", profile_tables)

    # Load selected profile data
    df = load_profile_data(conn, selected_table)

    if df.empty:
        st.warning("No data found in this profile table.")
        return

    # Show latest run summary
    st.subheader(f"Latest Run Summary: {selected_table}")

    latest_run_date = df['RUN_DATE'].max()
    latest_df = df[df['RUN_DATE'] == latest_run_date]

    st.dataframe(latest_df)

    # Row Count Trend
    st.subheader("Row Count Trend")
    row_count_df = df[['RUN_DATE', 'ROW_COUNT']].drop_duplicates().sort_values('RUN_DATE')
    fig_row_count = px.line(row_count_df, x='RUN_DATE', y='ROW_COUNT', markers=True)
    st.plotly_chart(fig_row_count, use_container_width=True)

    # Null % Trend for Top N columns
    st.subheader("Null % Trend (Top 10 Columns)")

    null_cols = [col for col in df.columns if col.endswith('_NULL_COUNT')]
    row_counts = df[['RUN_DATE', 'ROW_COUNT']].drop_duplicates().set_index('RUN_DATE')

    # Compute Null % per column per run_date
    null_pct_df = pd.DataFrame()
    null_pct_df['RUN_DATE'] = df['RUN_DATE']

    for col in null_cols:
        null_pct_df[col] = df[col] / df['ROW_COUNT'] * 100

    # Melt for plotting
    null_pct_melt = null_pct_df.melt(id_vars='RUN_DATE', var_name='COLUMN', value_name='NULL_PERCENT')

    # Aggregate mean NULL % per column to find top N columns
    mean_null_pct = null_pct_melt.groupby('COLUMN')['NULL_PERCENT'].mean().sort_values(ascending=False)
    top_n_columns = mean_null_pct.head(10).index.tolist()

    # Filter melted df
    null_pct_melt_top_n = null_pct_melt[null_pct_melt['COLUMN'].isin(top_n_columns)]

    # Plot
    fig_null_pct = px.line(null_pct_melt_top_n, x='RUN_DATE', y='NULL_PERCENT', color='COLUMN', markers=True)
    st.plotly_chart(fig_null_pct, use_container_width=True)

    # Option to download profile data
    st.subheader("Download Profile Data")
    st.download_button(
        label="Download CSV",
        data=df.to_csv(index=False).encode('utf-8'),
        file_name=f"{selected_table}.csv",
        mime='text/csv'
    )

    # Close connection
    conn.close()

if __name__ == "__main__":
    main()
