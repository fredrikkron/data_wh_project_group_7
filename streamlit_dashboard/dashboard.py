import streamlit as st
from data_wh_connection import query_job_table

def layout():
    st.title("Group WH")

    df_pedagogik = query_job_table("marts_pedagogik")
    df_kultur = query_job_table("marts_kultur")
    df_bygg = query_job_table("marts_bygg")

    st.dataframe(df_pedagogik.head())

    st.dataframe(df_kultur.head())

    st.dataframe(df_bygg.head())
   

if __name__ == "__main__":
    layout()