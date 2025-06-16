# app.py
import streamlit as st
from snowflake.snowpark.context import get_active_session
import pandas as pd
import altair as alt

st.set_page_config(layout="wide", page_title="Readmission by Diagnosis")
session = get_active_session()

@st.cache_data
def load_df():
    df = session.sql("""
        SELECT METRIC, AVG_VALUE
        FROM MARTS.MART_READMISSION_BY_DIAGNOSIS
    """).to_pandas()
    df.columns = [c.upper() for c in df.columns]
    return df

df = load_df()

order = [
    'Hospitalizations per 1000 days',
    'ED visits per 1000 days',
    '% Short-stay ED visits',
    '% Short-stay rehospitalizations'
]
df['METRIC'] = pd.Categorical(df['METRIC'], categories=order, ordered=True)

st.title("Nationwide 30-Day Readmission Metrics by Diagnosis")

base = alt.Chart(df).encode(
    x=alt.X('METRIC:N', sort=order, title=None),
    y=alt.Y('AVG_VALUE:Q', title='Average Value'),
    color=alt.Color('METRIC:N', scale=alt.Scale(scheme='dark2')),
    tooltip=[alt.Tooltip('METRIC:N', title='Category'),
             alt.Tooltip('AVG_VALUE:Q', format='.2f')]
)

bars = base.mark_bar()
labels = base.mark_text(dy=-5, fontWeight='bold').encode(text=alt.Text('AVG_VALUE:Q', format='.2f'))

chart = (bars + labels).properties(
    width=600,
    height=400
).configure_axisX(labelAngle=-45)

st.altair_chart(chart, use_container_width=True)
st.caption("Source: MARTS.MART_READMISSION_BY_DIAGNOSIS")
