with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    employer__name,
    employer__workplace,
    workplace_address__municipality,
    employer__organization_number,
    coalesce(workplace_address__street_address, 'Other') as workplace_address__street_address,
    coalesce(workplace_address__region, 'Other') as workplace_address__region,
    coalesce(workplace_address__postcode, 'Other') as workplace_address__postcode,
    COALESCE(
        UPPER(SUBSTR(workplace_address__city,1,1)) || LOWER(SUBSTR(workplace_address__city,2)),
        'Other'
    ) AS workplace_address__city,
    workplace_address__country
from stg_job_ads

