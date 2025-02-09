import streamlit as st
import pandas as pd
import numpy as np

st.title("Patient Readmission Model")
st.header("Predictive Model vs LACE Index")
st.text("Comparision between predictive model & lace index accuracy")
encounter = pd.read_parquet("../dataset/encounter.parquet")
encounter["encounterYear"] = encounter["encounterTs"].dt.year
total_encounter = encounter.groupby("encounterYear").size().reset_index(name="count")
model_encounter = (
    encounter[encounter["prediction"] == encounter["readmissionStatus"]]
    .groupby("encounterYear")
    .size()
    .reset_index(name="count")
)

# Calculate LACE accuracy per year
lace_encounter = (
    encounter[encounter["lace_prediction"] == encounter["readmissionStatus"]]
    .groupby("encounterYear")
    .size()
    .reset_index(name="count")
)

# Encounter Left join
result = total_encounter.merge(model_encounter, on="encounterYear", how="left", suffixes=("", "_model"))
result = result.merge(lace_encounter, on="encounterYear", how="left", suffixes=("", "_lace"))
# Calculate percentages
result["model_prediction"] = round(result["count_model"] * 100 / result["count"], 2)
result["lace_prediction"] = round(result["count_lace"] * 100 / result["count"], 2)

result = result[["encounterYear", "model_prediction", "lace_prediction"]].sort_values("encounterYear", ascending=False)

st.line_chart(result, x="encounterYear", y=["model_prediction", "lace_prediction"])