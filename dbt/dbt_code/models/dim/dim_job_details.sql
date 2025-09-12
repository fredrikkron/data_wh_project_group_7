with src_job_details as (select * from {{ ref('src_job_details') }})

select
    {{ dbt_utils.generate_surrogate_key(['job_details_id']) }} as job_details_id,
    job_id,
    headline,
    description__text,
    description__text_formatted,
    employment_type__label,
    duration__label,
    salary_type__label,
    scope_of_work__min,
    scope_of_work__max
from src_job_details
