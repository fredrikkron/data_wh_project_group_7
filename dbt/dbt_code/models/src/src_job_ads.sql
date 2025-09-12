with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    occupation__label,
    id as job_details_id,
    employer__workplace,
    workplace_address__municipality,
    id as auxilliary_attributes_id,
    number_of_vacancies AS vacancies,
    relevance,
    application_deadline
from stg_job_ads
order by application_deadline