# app.py
import streamlit as st
from snowflake.snowpark.context import get_active_session
import pandas as pd
import altair as alt

st.set_page_config(layout="wide", page_title="30-Day Readmission Metrics")
session = get_active_session()

@st.cache_data(show_spinner=False)
def load_readmission_df():
    df = session.sql("""
        SELECT
            STATE,
            HOSP_PER_1K_DAYS,
            ED_VISITS_PER_1K_DAYS,
            ED_VISIT_PCT,
            REHOSPITALIZATION_PCT
        FROM MARTS.MART_READMISSION_BY_STATE
    """).to_pandas()
    df.columns = [c.upper() for c in df.columns]
    return df

df = load_readmission_df()

df = df.melt(
    id_vars=["STATE"],
    value_vars=[
        "HOSP_PER_1K_DAYS",
        "ED_VISITS_PER_1K_DAYS",
        "ED_VISIT_PCT",
        "REHOSPITALIZATION_PCT",
    ],
    var_name="METRIC",
    value_name="VALUE",
)

label_map = {
    "HOSP_PER_1K_DAYS": "Hospitalizations per 1000 long‑stay days",
    "ED_VISITS_PER_1K_DAYS": "ED visits per 1000 long‑stay days",
    "ED_VISIT_PCT": "% Short‑stay ED visits",
    "REHOSPITALIZATION_PCT": "% Short‑stay rehospitalizations",
}
df["metric_label"] = df["METRIC"].map(label_map)
order = list(label_map.values())
df["metric_label"] = pd.Categorical(df["metric_label"], categories=order, ordered=True)

st.title("📊 30‑Day Readmission Metrics by Diagnosis Category")
st.markdown("State-level comparison of readmissions and ED visits.")

# Build chart layers
bar = alt.Chart(df).mark_bar().encode(
    x=alt.X("metric_label:N", title=None),
    y=alt.Y("VALUE:Q", title="Value"),
    color=alt.Color("metric_label:N", scale=alt.Scale(scheme="purpleblue"), legend=None),
    tooltip=[
        alt.Tooltip("STATE:N", title="State"),
        alt.Tooltip("metric_label:N", title="Metric"),
        alt.Tooltip("VALUE:Q", format=".2f", title="Value")
    ]
)

text = bar.mark_text(align="center", dy=-5, fontWeight="bold").encode(
    text=alt.Text("VALUE:Q", format=".2f")
)

layered = (bar + text).properties(
    width=600,
    height=400
).configure_axisX(labelAngle=-45)

st.altair_chart(layered, use_container_width=True)

st.caption("Source: MARTS.MART_READMISSION_BY_STATE")
