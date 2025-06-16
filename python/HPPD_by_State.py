import snowflake.connector
import streamlit as st
import pandas as pd
import plotly.express as px

# Configurable parameters
SNOWFLAKE_USER = 'PC_DBT_USER'
SNOWFLAKE_PASSWORD = 'ThreeKings21@1234'
SNOWFLAKE_ACCOUNT = 'BWPLKWD-SR59008'
SNOWFLAKE_WAREHOUSE = 'COMPUTE_WH'
SNOWFLAKE_DATABASE = 'HEALTHCARE'
SNOWFLAKE_SCHEMA = 'MARTS'

# Connect to Snowflake
conn = snowflake.connector.connect(
    user=SNOWFLAKE_USER,
    password=SNOWFLAKE_PASSWORD,
    account=SNOWFLAKE_ACCOUNT,
    warehouse=SNOWFLAKE_WAREHOUSE,
    database=SNOWFLAKE_DATABASE,
    schema=SNOWFLAKE_SCHEMA
)


st.set_page_config(layout="wide")
st.title("🗺️ Average Nursing Hours Per Patient Day (HPPD) by State")


@st.cache_data
def load_data():
    query = f"SELECT * FROM {SNOWFLAKE_DATABASE}.{SNOWFLAKE_SCHEMA}.MART_NURSING_HPPD_BY_STATE;"
    df = pd.read_sql(query, conn)
    df.columns = df.columns.str.upper()
    # Validate state codes
    df = df[df['STATE'].str.len() == 2]
    df['AVG_TOTAL_HPPD'] = pd.to_numeric(df['AVG_TOTAL_HPPD'], errors='coerce')
    return df.dropna(subset=['AVG_TOTAL_HPPD'])

df = load_data()
st.dataframe(df, use_container_width=True)

fig = px.choropleth(
    df,
    locations="STATE",
    locationmode="USA-states",
    color="AVG_TOTAL_HPPD",
    color_continuous_scale="Blues",
    scope="usa",
    labels={"AVG_TOTAL_HPPD": "Avg Hrs/Day"}
)

fig.update_geos(fitbounds="locations", visible=False)
fig.update_layout(margin={"r":0,"t":50,"l":0,"b":0})

st.plotly_chart(fig, use_container_width=True)

