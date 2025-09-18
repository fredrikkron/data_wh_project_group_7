{% docs __overview__ %}

# HR Job Ads Project Overview


This dbt project models job advertisement data to support **HR analytics**.

---

## Data Flow

1. **Sources**
   Job ads are ingested from external source tables and cleaned in staging models.

2. **Dimension Models**
   - **`dim_occupation`**: unique occupations, grouped into broader categories and fields.
   - **`dim_job_details`**: detailed attributes for each job ad (e.g. headline, description, employment type, duration).
   - **`dim_employer`**: employer information, including workplace and organization details.
   - **`dim_auxilliary_attributes`**: extra attributes such as experience and driving requirements.

3. **Fact Model**
   - **`fct_job_ads`**: the central fact table, storing metrics such as number of vacancies, application deadlines, and relevance scores.

4. **Mart Models**
   Business-friendly subsets of the data tailored for analysis:
   - **`marts_pedagogik`**: pedagogical jobs.
   - **`marts_kultur`**: culture, media, and design jobs.
   - **`marts_bygg`**: construction and infrastructure jobs.

---

## Testing & Documentation

- **Testing**:
  We validate data quality with dbt tests. Examples:
  - Foreign keys (e.g. `occupation_id` in `fct_job_ads` must exist in `dim_occupation`).
  - Column constraints (e.g. `relevance` must be between 0 and 1, `vacancies` max capped at 300).
  - Not-null constraints (e.g. every `job_id` in `dim_job_details` must link back to a fact).

- **Documentation**:
  Every model and column includes a clear description in `schema.yml`.
  This ensures BI users and new developers can easily understand the purpose of each table and column.

{% enddocs %}
