import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

st.title("Patient Readmission Model")
st.header("Dashboard")
st.text("Sample Data")
encounter = pd.read_parquet("../dataset/encounter.parquet")
encounter["encounterYear"] = encounter["encounterTs"].dt.year

st.dataframe(encounter[encounter['encounterYear'] == 2200].head(5))

st.subheader("Readmission Over Year")
st.line_chart(
    encounter.groupby(['encounterYear', 'readmissionStatus']).size().reset_index(name='count'),
    x="encounterYear", y="count", color="readmissionStatus")

def plot_pie_chart(df, labels, value='count'):
    fig, ax = plt.subplots()
    ax.pie(df[value], labels=df[labels], autopct='%1.1f%%', startangle=90)
    ax.axis('equal')  # Equal aspect ratio ensures the pie is circular.
    return fig

st.subheader("Admission Source Distribution")
st.write("Pie chart representation of admission sources.")

st.pyplot(plot_pie_chart(encounter.groupby(['priority']).size().reset_index(name='count'), 'priority'))

st.subheader("Age Group Over Year")
st.bar_chart(
    encounter.groupby(['encounterYear', 'encounterClass']).size().reset_index(name='count'),
    x="encounterYear", y="count", color="encounterClass", horizontal=True)

st.subheader("Age Group Over Year")
st.line_chart(
    encounter.groupby(['encounterYear', 'ageGroup']).size().reset_index(name='count'),
    x="encounterYear", y="count", color="ageGroup")

st.subheader("Priority Over Year")
st.line_chart(
    encounter.groupby(['encounterYear', 'priority']).size().reset_index(name='count'),
    x="encounterYear", y="count", color="priority")