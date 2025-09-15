import streamlit as st
from data_wh_connection import query_job_table

def layout():
    # --- Title + Logo Side by Side ---
    col1, col2 = st.columns([3, 1])  # ratio for title : logo
    with col1:
        st.title("HR Job Ads Dashboard")
    with col2:
        st.image("streamlit_dashboard/images/HR_LOGO.png", width=160)  # adjust width as needed

    # Load data for each occupation field
    df_pedagogik = query_job_table("marts_pedagogik")
    df_kultur = query_job_table("marts_kultur")
    df_bygg = query_job_table("marts_bygg")

    # Ensure column names are lowercase
    df_pedagogik.columns = df_pedagogik.columns.str.lower()
    df_kultur.columns = df_kultur.columns.str.lower()
    df_bygg.columns = df_bygg.columns.str.lower()

    tables = {
    "Bygg och anläggning":df_bygg,
    "Kultur, media, design":df_kultur,
    "Pedagogik":df_pedagogik
}

    st.markdown("## Total Vacancies")
    cols = st.columns(3)

    with cols[0]:
        st.metric(label="Pedagogik", value=df_pedagogik["vacancies"].sum())
    with cols[1]:
        st.metric(label="Kultur, media, design", value=df_kultur["vacancies"].sum())
    with cols[2]:
        st.metric(label="Bygg och anläggning", value=df_bygg["vacancies"].sum())


    st.markdown("### Data for vacancies filtered by " \
    "city and occupation")
    select_table = st.selectbox("Select occupation field", list(tables.keys()))
    df_pick = tables[select_table]
    cols = st.columns(2)

    with cols[0]:
        df_city = (
            df_pick.groupby("workplace_address__city", as_index=False)["vacancies"]
            .sum()
            .sort_values("vacancies", ascending=False)
        )
        st.dataframe(df_city, use_container_width=True)

    with cols[1]:
        df_occ = (
            df_pick.groupby("occupation", as_index=False)["vacancies"]
            .sum()
            .sort_values("vacancies", ascending=False)
        )
        st.dataframe(df_occ, use_container_width=True)


if __name__ == "__main__":
    layout()