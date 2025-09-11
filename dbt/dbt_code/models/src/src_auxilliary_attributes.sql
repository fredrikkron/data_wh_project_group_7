with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    id AS auxilliary_attributes_id,
    experience_required,
    driving_license_required,
    access_to_own_car
from stg_job_ads