with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    id AS job_details_id,
    headline,
    description__text,
    description__text_formatted,
    employment_type__label,
    duration__label,
    salary_type__label,
    scope_of_work__min,
    scope_of_work__max
from stg_job_ads