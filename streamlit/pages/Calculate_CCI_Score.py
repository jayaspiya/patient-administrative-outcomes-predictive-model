import streamlit as st
import pandas as pd
import numpy as np

st.title("Patient Readmission Model")
st.header("Calculate Charlson Comorbidity Index (CCI)")

score = 0

ageGroup = {
    "<50 years (+0pts)": 0,
    "50-59 years (+1pts)": 1,
    "60-69 years (+2pts)": 2,
    "70-79 years (+3pts)": 3,
    "≥80 years (+4pts)": 4
}
inputAgeGroup = st.selectbox(
    "Input Age Group:",
    ageGroup.keys(),
)
score += ageGroup[inputAgeGroup]

historyMI = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryMI = st.segmented_control(
    "Myocardial infarction", historyMI.keys(), key="MI"
)
score += historyMI.get(inputHistoryMI, 0)

historyCHF = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryCHF = st.segmented_control(
    "Congestive Heart Failure", historyCHF.keys(), key="CHF"
)
score += historyCHF.get(inputHistoryCHF, 0)

historyPVD = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryPVD = st.segmented_control(
    "Peripheral vascular disease", historyPVD.keys(), key="PVD"
)
score += historyPVD.get(inputHistoryPVD, 0)

historyCVAorTRA = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryCVAorTRA = st.segmented_control(
    "Cerebrovascular Accident", historyCVAorTRA.keys(), key="historyCVAorTRA"
)
score += historyCVAorTRA.get(inputHistoryCVAorTRA, 0)

historyDementia = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryDementia = st.segmented_control(
    "Dementia Chronic cognitive deficit", historyDementia.keys(), key="historyDementia"
)
score += historyDementia.get(inputHistoryDementia, 0)

historyCPD = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryCPD = st.segmented_control(
    "Chronic pulmonary disease", historyCPD.keys(), key="historyCPD"
)
score += historyCPD.get(inputHistoryCPD, 0)

historyCTD = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryCTD = st.segmented_control(
    "Connective tissue disease", historyCTD.keys(), key="historyCTD"
)
score += historyCTD.get(inputHistoryCTD, 0)

historyPUD = {
    "No (+0pts)": 0,
    "Yes (+1pts)": 1
}
inputHistoryPUD = st.segmented_control(
    "Peptic ulcer disease", historyPUD.keys(), key="historyPUD"
)
score += historyPUD.get(inputHistoryPUD, 0)

historyLD = {
    "No (+0pts)": 0,
    "Mild (+1pts)": 1,
    "Moderate to Severe (+3pts)": 3,
}
inputHistoryLD = st.segmented_control(
    "Liver disease", historyLD.keys(), key="historyLD"
)
score += historyLD.get(inputHistoryLD, 0)

historyDM = {
    "None or diet-controlled (+0pts)": 0,
    "Uncomplicated(+1pts)": 1,
    "End-organ damage (+2pts)": 2,
}
inputHistoryDM = st.segmented_control(
    "Diabetes mellitus", historyDM.keys(), key="historyDM"
)
score += historyDM.get(inputHistoryDM, 0)

historyHemi = {
    "No (+0pts)": 0,
    "Yes (+2pts)": 2
}
inputHistoryHemi = st.segmented_control(
    "Hemiplegia", historyHemi.keys(), key="historyHemi"
)
score += historyHemi.get(inputHistoryHemi, 0)

historyCKD = {
    "No (+0pts)": 0,
    "Yes (+2pts)": 2
}
inputHistoryCKD = st.segmented_control(
    "Chronic Kidney Disease", historyCKD.keys(), key="historyCKD"
)
score += historyCKD.get(inputHistoryCKD, 0)

historyST={
    "None (+0pts)": 0,
    "Localized (+2pts)": 2,
    "Metastatic (+6pts)": 6,
}
inputHiistoryST = st.segmented_control(
    "Diabetes mellitus", historyST.keys(), key="history"
)
score += historyST.get(inputHiistoryST, 0)

historyLeukemia = {
    "No (+0pts)": 0,
    "Yes (+2pts)": 2
}
inputHistoryLeukemia = st.segmented_control(
    "Leukemia", historyLeukemia.keys(), key="historyLeukemia"
)
score += historyLeukemia.get(inputHistoryLeukemia, 0)

historyLymphoma = {
    "No (+0pts)": 0,
    "Yes (+2pts)": 2
}
inputHistoryLymphoma = st.segmented_control(
    "Lymphoma", historyLymphoma.keys(), key="historyLymphoma"
)
score += historyLymphoma.get(inputHistoryLymphoma, 0)

historyAIDS = {
    "No (+0pts)": 0,
    "Yes (+6pts)": 6
}
inputHistoryAIDS = st.segmented_control(
    "AIDS", historyAIDS.keys(), key="historyAIDS"
)
score += historyAIDS.get(inputHistoryAIDS, 0)

st.write("Charlson Comorbidity Index:", score)


