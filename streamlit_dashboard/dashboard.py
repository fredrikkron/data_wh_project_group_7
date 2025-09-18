import streamlit as st
from data_wh_connection import query_job_table
import plotly.express as px
import pandas as pd

def layout():
    # Title + Logo Side by Side
    col1, col2 = st.columns([3, 1])  # ratio for title : logo
    with col1:
        st.title("HR Job Ads Dashboard")
    with col2:
        st.image("streamlit_dashboard/images/HR_LOGO.png", width=170)

    # Load data for each occupation field
    df_pedagogik = query_job_table("marts_pedagogik")
    df_kultur = query_job_table("marts_kultur")
    df_bygg = query_job_table("marts_bygg")

    # Mapping tables for selectbox
    tables = {
        "Bygg och anläggning": df_bygg,
        "Kultur, media, design": df_kultur,
        "Pedagogik": df_pedagogik
    }

    # Total Vacancies Metrics
    st.markdown("### Total Vacancies")
    cols = st.columns(3)

    with cols[0]:
        st.metric(label="Bygg och anläggning", value=df_bygg["Vacancies"].sum())
    with cols[1]:
        st.metric(label="Kultur, media, design", value=df_kultur["Vacancies"].sum())
    with cols[2]:
        st.metric(label="Pedagogik", value=df_pedagogik["Vacancies"].sum())

    # Data grouped by city and occupation
    st.markdown("### Data for vacancies filtered by city and occupation")
    select_table = st.selectbox("Select occupation field", list(tables.keys()), key="table_selection")
    df_pick = tables[select_table]

    cols = st.columns(2)

    with cols[0]:
        df_city = (
            df_pick.groupby("Workplace City", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
            .set_index("Workplace City")
        )
        st.dataframe(df_city, width='stretch')

    with cols[1]:
        df_occ = (
            df_pick.groupby("Occupation", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
            .set_index("Occupation")
        )
        st.dataframe(df_occ, width='stretch')

# Bar charts Top 10 Occupation Groups & Top 10 Regions
    cols = st.columns(1)

    with cols[0]:
        df_top10_occ_group = (
            df_pick.groupby("Occupation Group", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
            .head(10)
        )

        fig_occ = px.bar(
            df_top10_occ_group,
            x="Vacancies",
            y="Occupation Group",
            orientation="h",
            text="Vacancies",
        )
        fig_occ.update_layout(
            title={'text': f"Top 10 Occupation Groups - {select_table}", 'font': {'size': 26}},
            yaxis=dict(title='', tickfont={'size': 14}),
            xaxis=dict(title=''),
            yaxis_categoryorder='total ascending'
        )
        fig_occ.update_xaxes(showticklabels=False)
        st.plotly_chart(fig_occ, width='stretch')

    cols = st.columns(1)

    with cols[0]:
        df_top10_region = (
            df_pick.groupby("Workplace Region", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
            .head(10)
        )

        fig_reg = px.bar(
            df_top10_region,
            x="Vacancies",
            y="Workplace Region",
            orientation="h",
            text="Vacancies",
        )
        fig_reg.update_layout(
            title={'text': f"Top 10 Regions - {select_table}", 'font': {'size': 26}},
            yaxis=dict(title='', tickfont={'size': 14}),
            xaxis=dict(title=''),
            yaxis_categoryorder='total ascending'
        )
        fig_reg.update_xaxes(showticklabels=False)
        st.plotly_chart(fig_reg, width='stretch')

    # Pie chart for Employment Type
    cols = st.columns(1)

    with cols[0]:
        df_emp_type = df_pick.groupby("Employment Type", as_index=False)["Vacancies"].sum()
        fig_emp_type = px.pie(
            df_emp_type,
            values="Vacancies",
            names="Employment Type",
            title="Vacancies by Employment Type"
        )
        fig_emp_type.update_layout(
            title={'text': "Vacancies by Employment Type", 'font': {'size': 26}},
        )
        st.plotly_chart(fig_emp_type, width='stretch')



    # --- Description filtering with optimized order ---
    st.markdown("### Data for filtering description of a job")

    # Step 1: Select Occupation Group
    selected_occ_group = st.selectbox(
        "Select occupation group",
        sorted(df_pick["Occupation Group"].unique()),
        index=None,
        placeholder="",
        key=f"occ_group_{select_table}"
    )

    if selected_occ_group:
        df_occ_group = df_pick[df_pick["Occupation Group"] == selected_occ_group]

        # Step 2: Select Occupation
        selected_occ = st.selectbox(
            "Select occupation",
            sorted(df_occ_group["Occupation"].unique()),
            index=None,
            placeholder="",
            key=f"occ_{select_table}"
        )
    else:
        df_occ_group = pd.DataFrame()
        selected_occ = None

    if selected_occ:
        df_occ = df_occ_group[df_occ_group["Occupation"] == selected_occ]

        # Step 3: Select Region
        selected_region = st.selectbox(
            "Select region",
            sorted(df_occ["Workplace Region"].unique()),
            index=None,
            placeholder="",
            key=f"region_{select_table}"
        )
    else:
        df_occ = pd.DataFrame()
        selected_region = None

    if selected_region:
        df_region = df_occ[df_occ["Workplace Region"] == selected_region]

        # Step 4: Select City
        selected_city = st.selectbox(
            "Select city",
            sorted(df_region["Workplace City"].unique()),
            index=None,
            placeholder="",
            key=f"city_{select_table}"
        )
    else:
        df_region = pd.DataFrame()
        selected_city = None

    if selected_city:
        df_city = df_region[df_region["Workplace City"] == selected_city]

        # Step 5: Select Job
        selected_job = st.selectbox(
            "Select job",
            df_city["Job Title"].tolist(),
            index=None,
            placeholder="",
            key=f"job_{select_table}"
        )
    else:
        df_city = pd.DataFrame()
        selected_job = None

    # --- Visa detaljer först när alla val är gjorda ---
    if selected_job:
        df_desc = df_city[df_city["Job Title"] == selected_job]

        cols = st.columns(3)
        with cols[0]:
            st.subheader("Job ID")
            st.write(df_desc["Job ID"].iloc[0])
        with cols[1]:
            st.subheader("Vacancies")
            st.text(df_desc["Vacancies"].iloc[0])
        with cols[2]:
            st.subheader("Employment")
            st.text(df_desc["Duration"].iloc[0])

        st.subheader("Description")
        st.write(df_desc["Description Formatted"].iloc[0], unsafe_allow_html=True)



if __name__ == "__main__":
    layout()