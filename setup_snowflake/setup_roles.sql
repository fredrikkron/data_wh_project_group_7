USE ROLE USERADMIN;
SELECT CURRENT_USER;

CREATE ROLE dlt_dev_role;
CREATE ROLE dlt_readonly_role;



-- Assign role
GRANT ROLE job_ads_dlt_role TO USER freja_user;
GRANT ROLE job_ads_dlt_role TO USER alice_user;
GRANT ROLE job_ads_dlt_role TO USER bob_user;





