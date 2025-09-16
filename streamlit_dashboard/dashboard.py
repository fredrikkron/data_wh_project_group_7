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
            .set_index("Workplace City")
        )
        st.dataframe(df_city, use_container_width=True)

    # Group by occupation
    with cols[1]:
        df_occ = (
            df_pick.groupby("Occupation", as_index=False)["Vacancies"]
            .sum()
            .sort_values("Vacancies", ascending=False)
            .set_index("Occupation")
        )
        st.dataframe(df_occ, use_container_width=True)


    # Description filtering

    st.markdown("## Data for filtering description of a job")

    cols = st.columns(1)

    # Selectboxes
    with cols[0]:
        selected_city = st.selectbox(
            "Select city",
            sorted(df_pick["Workplace City"].unique()),
            key=f"city_{select_table}"
        )

        df_chosen_city = df_pick[df_pick["Workplace City"] == selected_city]


        selected_occ_group = st.selectbox(
            "Select occupation group",
            sorted(df_chosen_city["Occupation Group"].unique()),
            key=f"occ_group_{select_table}"
        )


        df_chosen_occ_group = df_chosen_city[df_chosen_city["Occupation Group"] == selected_occ_group]

        selected_occ = st.selectbox(
            "Select occupation",
            sorted(df_chosen_occ_group["Occupation"].unique()),
            key=f"occ_{select_table}"
        )


        df_chosen_occ = df_chosen_occ_group[df_chosen_occ_group["Occupation"] == selected_occ]

        selected_job = st.selectbox(
            "Select job",
            df_chosen_occ["Job Title"],
            key=f"job_{select_table}"
        )

        df_desc = df_pick[
            (df_pick["Workplace City"] == selected_city) &
            (df_pick["Occupation Group"] == selected_occ_group) &
            (df_pick["Occupation"] == selected_occ) &
            (df_pick["Job Title"] == selected_job)
        ]

        # KPI and description
        cols = st.columns(2)

        with cols[0]:
            st.subheader("Job ID")
            st.write(df_desc["Job ID"].iloc[0])
        # with cols[1]:
            # More relevant KPI

        
        st.subheader("Description")
        st.write(df_desc["Description"].iloc[0])



# --- Top 10 Occupation Groups ---

    # Group by Occupation Group
    df_top10_occ_group = (
        df_pick.groupby("Occupation Group", as_index=False)["Vacancies"]
        .sum()
        .sort_values("Vacancies", ascending=False)
        .head(10)
    )
    # Horizontal bar chart 
    fig = px.bar(
        df_top10_occ_group,
        x="Vacancies",
        y="Occupation Group",
        orientation="h",
        text="Vacancies",
    )

    fig.update_layout(
        title={
            'text': f"Top 10 Occupation Groups by vacancies - {select_table}",
            'font': {'size': 24} 
        },
        yaxis=dict(
            title='', 
            tickfont={'size': 16}
        ),
        xaxis=dict(
            title=''  
        ),
        yaxis_categoryorder='total ascending' 
    )

    fig.update_xaxes(showticklabels=False)
    st.plotly_chart(fig, use_container_width=True)




if __name__ == "__main__":
    layout()
