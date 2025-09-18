with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    employer__name,
    employer__workplace,
    workplace_address__municipality,
    employer__organization_number,
    coalesce(workplace_address__street_address, 'Ej specificerad') as workplace_address__street_address,
    coalesce(workplace_address__region, 'Ej specificerad') as workplace_address__region,
    coalesce(workplace_address__postcode, 'Ej specificerad') as workplace_address__postcode,
    coalesce(INITCAP(TRIM(REGEXP_REPLACE(workplace_address__city, '[^A-Za-zÅÄÖåäö ]', ''))), 'Ej specificerad') AS workplace_address__city,
    workplace_address__country
from stg_job_ads