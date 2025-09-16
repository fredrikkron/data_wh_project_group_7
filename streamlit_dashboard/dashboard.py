import streamlit as st
from data_wh_connection import query_job_table
import plotly.express as px

def layout():
    # --- Title + Logo Side by Side ---
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

    # --- Total Vacancies Metrics ---
    st.markdown("## Total Vacancies")
    cols = st.columns(3)

    with cols[0]:
        st.metric(label="Bygg och anläggning", value=df_bygg["Vacancies"].sum())
    with cols[1]:
        st.metric(label="Kultur, media, design", value=df_kultur["Vacancies"].sum())
    with cols[2]:
        st.metric(label="Pedagogik", value=df_pedagogik["Vacancies"].sum())

    # --- Data grouped by city and occupation ---
    st.markdown("### Data for vacancies filtered by city and occupation")
    select_table = st.selectbox("Select occupation field", list(tables.keys()), key="table_selection")
    df_pick = tables[select_table]

    cols = st.columns(2)

    # Group by city
    with cols[0]:
        df_city = (
            df_pick.groupby("Workplace City", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
        )
        st.dataframe(df_city, use_container_width=True)

    # Group by occupation
    with cols[1]:
        df_occ = (
            df_pick.groupby("Occupation", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
        )
        st.dataframe(df_occ, use_container_width=True)


    # Description filtering

    st.markdown("## Data for filtering description of a job")

    cols = st.columns(1)

    with cols[0]:
        selected_city = st.selectbox(
            "Select city",
            sorted(df_pick["Workplace City"].unique()),
            key=f"{select_table}"
        )

        df_chosen_city = df_pick[df_pick["Workplace City"] == selected_city]

        selected_occ_group = st.selectbox(
            "Select occupation group",
            sorted(df_chosen_city["Occupation Group"].unique()),
            key=f"occ_group {select_table}"
        )

        df_chosen_occupation_group = df_pick[df_pick["Occupation Group"] == selected_occ_group]

        selected_occ_group = st.selectbox(
            "Select occupation",
            sorted(df_chosen_occupation_group["Occupation"].unique()),
            key=f"occ {select_table}"
        )





# --- Top 10 Occupation Groups ---
    st.markdown("## Top 10 Occupation Groups by Vacancies")

    # Group by Occupation Group
    df_top10_occ_group = (
        df_pick.groupby("Occupation Group", as_index=False)["Vacancies"]
        .sum()
        .sort_values("Vacancies", ascending=False)
        .head(10)
    )

    # Horizontal bar chart using Plotly
    fig = px.bar(
        df_top10_occ_group,
        x="Vacancies",
        y="Occupation Group",
        orientation="h",
        text="Vacancies",
        title=f"Top 10 Occupation Groups in {select_table}"
    )
    fig.update_layout(yaxis={'categoryorder':'total ascending'})  # biggest on top
    st.plotly_chart(fig, use_container_width=True)




if __name__ == "__main__":
    layout()
# df_pick["Occupation Group"].unique()