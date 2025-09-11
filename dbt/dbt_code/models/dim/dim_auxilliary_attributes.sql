with src_auxilliary_attributes as (select * from {{ ref('src_auxilliary_attributes') }})

select
    {{ dbt_utils.generate_surrogate_key(['auxilliary_attributes_id'])}} as auxilliary_attributes_id,
    experience_required,
    driving_license_required,
    access_to_own_car
from src_auxilliary_attributes