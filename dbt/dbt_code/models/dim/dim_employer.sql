with src_employer as (select * from {{ ref('src_employer') }})

select
    {{ dbt_utils.generate_surrogate_key(['employer__workplace', 'workplace_address__municipality']) }} as employer_id,
    employer__name,
    employer__workplace,
    employer__organization_number,
    workplace_address__street_address,
    workplace_address__region,
    workplace_address__postcode,
    workplace_address__city,
    workplace_address__country
from src_employer

