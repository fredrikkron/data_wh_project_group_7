SELECT
    j.job_id AS "Job ID",
    MAX(o.occupation) AS "Occupation",
    MAX(o.occupation_group) AS "Occupation Group",
    MAX(o.occupation_field) AS "Occupation Field",
    MAX(j.headline) AS "Job Title",
    MAX(j.description__text) AS "Description",
    MAX(j.description__text_formatted) AS "Description Formatted",
    MAX(j.employment_type__label) AS "Employment Type",
    MAX(j.duration__label) AS "Duration",
    MAX(j.salary_type__label) AS "Salary Type",
    MIN(j.scope_of_work__min) AS "Min Scope of Work",
    MAX(j.scope_of_work__max) AS "Max Scope of Work",
    MAX(f.vacancies) AS "Vacancies",
    MAX(f.relevance) AS "Relevance",
    MAX(f.application_deadline) AS "Application Deadline",
    MAX(e.employer__name) AS "Employer Name",
    MAX(e.employer__workplace) AS "Employer Workplace",
    MAX(e.employer__organization_number) AS "Employer Org Number",
    MAX(e.workplace_address__street_address) AS "Workplace Street",
    MAX(e.workplace_address__region) AS "Workplace Region",
    MAX(e.workplace_address__postcode) AS "Workplace Postcode",
    MAX(e.workplace_address__city) AS "Workplace City",
    MAX(e.workplace_address__country) AS "Workplace Country",
    MAX(a.experience_required) AS "Experience Required",
    MAX(a.driving_license_required) AS "Driving License Required",
    MAX(a.access_to_own_car) AS "Access to Own Car"
FROM fct_job_ads f
INNER JOIN dim_occupation o
    ON f.occupation_id = o.occupation_id
INNER JOIN dim_job_details j
    ON f.job_details_id = j.job_details_id
INNER JOIN dim_employer e
    ON f.employer_id = e.employer_id
INNER JOIN dim_auxilliary_attributes a
    ON f.auxilliary_attributes_id = a.auxilliary_attributes_id
WHERE o.occupation_field = 'Bygg och anläggning'
    AND f.application_deadline >= CURRENT_DATE
GROUP BY j.job_id