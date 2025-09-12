with
    fct_job_ads as (select * from {{ ref('fct_job_ads') }}),
    dim_occupation as (select * from {{ ref('dim_occupation') }}),
    dim_job_details as (select * from {{ ref('dim_job_details') }}),
    dim_auxilliary_attributes as (select * from {{ ref('dim_auxilliary_attributes') }}),
    dim_employer as (select * from {{ ref('dim_employer') }})
    
SELECT
    o.occupation, 
    o.occupation_group,
    o.occupation_field,
    j.job_id,
    j.headline, 
    j.description__text,
    j.description__text_formatted,
    j.employment_type__label,
    j.duration__label,
    j.salary_type__label,
    j.scope_of_work__min,
    j.scope_of_work__max,
    f.vacancies,
    f.relevance,
    f.application_deadline,
    e.employer__name,
    e.employer__workplace,
    e.employer__organization_number,
    e.workplace_address__street_address,
    e.workplace_address__region,
    e.workplace_address__postcode,
    e.workplace_address__city,
    e.workplace_address__country,
    a.experience_required,
    a.driving_license_required,
    a.access_to_own_car
FROM fct_job_ads f
LEFT JOIN dim_occupation o
    ON f.occupation_id = o.occupation_id
LEFT JOIN dim_job_details j
    ON f.job_details_id = j.job_details_id
LEFT JOIN dim_employer e
    ON f.employer_id = e.employer_id
LEFT JOIN dim_auxilliary_attributes a
    ON f.auxilliary_attributes_id = a.auxilliary_attributes_id
WHERE O.occupation_field = 'Pedagogik'