import streamlit as st
import pandas as pd
import numpy as np
from sklearn.metrics import accuracy_score, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

st.title("Patient Readmission Model")
st.header("Predictive Model vs LACE Index")
st.text("Comparision between predictive model & lace index accuracy")
encounter = pd.read_parquet("../dataset/encounter.parquet")
encounter["encounterYear"] = encounter["encounterTs"].dt.year

accuracy_1 = accuracy_score(encounter['readmissionStatus'], encounter['lace_prediction'])
accuracy_2 = accuracy_score(encounter['readmissionStatus'], encounter['prediction'])

st.write("### Accuracy Scores")
st.write(f"- Lace Prediction: **{accuracy_1:.2f}**")
st.write(f"- Model Prediction: **{accuracy_2:.2f}**")

st.write("### Confusion Matrix")
conf_matrix_1 = confusion_matrix(encounter['readmissionStatus'], encounter['lace_prediction'])
conf_matrix_2 = confusion_matrix(encounter['readmissionStatus'], encounter['prediction'])

fig, axes = plt.subplots(1, 2, figsize=(12, 5))
sns.heatmap(conf_matrix_1, annot=True, fmt='d', cmap='Blues', ax=axes[0],
            xticklabels=['Predicted False', 'Predicted True'], 
            yticklabels=['Actual False', 'Actual True'])

axes[0].set_title('LACE Prediction')
axes[0].set_xlabel('Predicted')
axes[0].set_ylabel('Actual')

sns.heatmap(conf_matrix_2, annot=True, fmt='d', cmap='Blues', ax=axes[1],
            xticklabels=['Predicted False', 'Predicted True'], 
            yticklabels=['Actual False', 'Actual True'])
axes[1].set_title('Model Prediction')
axes[1].set_xlabel('Predicted')
axes[1].set_ylabel('Actual')
st.pyplot(fig)

st.write("### Accuracy Over Year")
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