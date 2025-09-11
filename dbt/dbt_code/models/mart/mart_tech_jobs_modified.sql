with
    fct_job_ads as (select * from {{ ref('fct_job_ads') }}),
    dim_occupation as (select * from {{ ref('dim_occupation') }}),
    dim_job_details as (select * from {{ ref('dim_job_details') }}),
    dim_auxilliary_attributes as (select * from {{ ref('dim_auxilliary_attributes') }}),
    dim_employer as (select * from {{ ref('dim_employer') }})
    
SELECT
    o.occupation_id,
    j.job_details_id,
    e.employer_id,
    a.auxilliary_attributes_id,
    f.vacancies,
    f.relevance,
    f.application_deadline
FROM fct_job_ads f
INNER JOIN dim_occupation o
    ON f.occupation_id = o.occupation_id
INNER JOIN dim_job_details j
    ON f.job_details_id = j.job_details_id
INNER JOIN dim_employer e
    ON f.employer_id = e.employer_id
INNER JOIN dim_auxilliary_attributes a
    ON f.auxilliary_attributes_id = a.auxilliary_attributes_id