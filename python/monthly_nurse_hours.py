import streamlit as st
from snowflake.snowpark.context import get_active_session
import pandas as pd
import altair as alt

session = get_active_session()
st.set_page_config(layout="wide")
st.title("🏥 Monthly Nurse Hours by Provider & Month per State")

@st.cache_data
def load_df(sql: str) -> pd.DataFrame:
    df = session.sql(sql).to_pandas()
    df.columns = [c.upper() for c in df.columns]
    month_order = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    df['MONTH_NAME'] = pd.Categorical(df['MONTH_NAME'], categories=month_order, ordered=True)
    # Sort for visual consistency
    return df.sort_values(['STATE', 'PROVIDER_NAME', 'MONTH_NAME'])

df = load_df("""
  SELECT PROVIDER_NAME, STATE, MONTH_NAME, TOTAL_NURSE_HOURS
  FROM MARTS.MART_MONTHLY_NURSE_HOURS
""")

for state in sorted(df["STATE"].unique()):
    st.subheader(f"State: {state}")
    d = df[df["STATE"] == state]

    chart = alt.Chart(d).mark_bar().encode(
        x=alt.X(
            'PROVIDER_NAME:N',
            title='Provider',
            sort=alt.EncodingSortField(
                field='TOTAL_NURSE_HOURS',  # sort by total hours
                op='sum',
                order='descending'
            )
        ),
        xOffset=alt.XOffset('MONTH_NAME:N',
            sort=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        ),
        y=alt.Y('TOTAL_NURSE_HOURS:Q', title='Total Hrs Worked'),
        color=alt.Color('MONTH_NAME:N', title='Month',
                        sort=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"])
    ).properties(
        width=40 * d['PROVIDER_NAME'].nunique(),  # dynamic width
        height=300,
        title=f"Monthly Nurse Hours by Provider — State: {state}"
    ).configure_axisX(
        labelAngle=-45,
        labelAlign='right'
    )

    st.altair_chart(chart, use_container_width=True)
