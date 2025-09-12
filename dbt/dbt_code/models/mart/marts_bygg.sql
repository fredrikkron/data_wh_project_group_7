SELECT
    j.job_id,
    MAX(o.occupation)        as occupation, 
    MAX(o.occupation_group)  as occupation_group,
    MAX(o.occupation_field)  as occupation_field,
    MAX(j.headline)          as headline,
    MAX(j.description__text) as description__text,
    MAX(j.description__text_formatted) as description__text_formatted,
    MAX(j.employment_type__label) as employment_type__label,
    MAX(j.duration__label)   as duration__label,
    MAX(j.salary_type__label) as salary_type__label,
    MIN(j.scope_of_work__min) as scope_of_work__min,
    MAX(j.scope_of_work__max) as scope_of_work__max,
    MAX(f.vacancies)         as vacancies,
    MAX(f.relevance)         as relevance,
    MAX(f.application_deadline) as application_deadline,
    MAX(e.employer__name)    as employer__name,
    MAX(e.employer__workplace) as employer__workplace,
    MAX(e.employer__organization_number) as employer__organization_number,
    MAX(e.workplace_address__street_address) as workplace_address__street_address,
    MAX(e.workplace_address__region) as workplace_address__region,
    MAX(e.workplace_address__postcode) as workplace_address__postcode,
    MAX(e.workplace_address__city) as workplace_address__city,
    MAX(e.workplace_address__country) as workplace_address__country,
    MAX(a.experience_required) as experience_required,
    MAX(a.driving_license_required) as driving_license_required,
    MAX(a.access_to_own_car) as access_to_own_car
FROM fct_job_ads f
INNER JOIN dim_occupation o
    ON f.occupation_id = o.occupation_id
INNER JOIN dim_job_details j
    ON f.job_details_id = j.job_details_id
INNER JOIN dim_employer e
    ON f.employer_id = e.employer_id
INNER JOIN dim_auxilliary_attributes a
    ON f.auxilliary_attributes_id = a.auxilliary_attributes_id
WHERE o.occupation_field = 'Bygg och anläggning'
GROUP BY j.job_id
