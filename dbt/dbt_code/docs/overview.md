{% docs __overview__ %}

# HR Job Ads Project Overview

This dbt project models job advertisement data to support HR analytics.  
The goal is to provide insights into **vacancies, occupations, and trends** for decision-making in HR departments.

## Data Flow
1. **Sources**: Job ads are ingested from external tables (e.g. marts_pedagogik, marts_kultur, marts_bygg).  
2. **Staging Models**: Standardize and clean source data for consistency.  
3. **Dimension Models**:  
   - `dim_occupation` contains unique occupations with surrogate keys.  
4. **Fact Models**:  
   - `fct_job_ads` stores key metrics like vacancies.  

## Purpose
This project allows HR teams to:  
- Get insight into number of open vacancies per occupation field and filter to understand data 
- Build dashboards in Streamlit
- etc

{% docs enddocs %}
