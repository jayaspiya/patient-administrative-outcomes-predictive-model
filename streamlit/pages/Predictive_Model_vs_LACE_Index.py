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

TN, FP, FN, TP = conf_matrix_1.ravel()
precision = TP / (TP + FP) if (TP + FP) > 0 else 0
recall = TP / (TP + FN) if (TP + FN) > 0 else 0
f1_score = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

TN2, FP2, FN2, TP2 = conf_matrix_2.ravel()
precision2 = TP2 / (TP2 + FP2) if (TP2 + FP2) > 0 else 0
recall2 = TP2 / (TP2 + FN2) if (TP2 + FN2) > 0 else 0
f1_score2 = 2 * (precision2 * recall2) / (precision2 + recall2) if (precision2 + recall2) > 0 else 0
metrics = ['Precision', 'Recall', 'F1-Score']
lace_scores = [precision, recall, f1_score]
model_scores = [precision2, recall2, f1_score2]

x = np.arange(len(metrics))
width = 0.3
fig, ax = plt.subplots()
ax.bar(x - width/2, lace_scores, width, label='LACE Prediction', color='b')
ax.bar(x + width/2, model_scores, width, label='Model Prediction', color='g')

ax.set_xlabel('Metrics')
ax.set_ylabel('Score')
ax.set_title('LACE vs Model Prediction Performance')
ax.set_xticks(x)
ax.set_xticklabels(metrics)
ax.set_ylim(0, 1.1)
ax.legend()
for i, v in enumerate(lace_scores):
    ax.text(i - width/2, v + 0.02, f"{v:.2f}", ha='center', fontsize=10)
for i, v in enumerate(model_scores):
    ax.text(i + width/2, v + 0.02, f"{v:.2f}", ha='center', fontsize=10)

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