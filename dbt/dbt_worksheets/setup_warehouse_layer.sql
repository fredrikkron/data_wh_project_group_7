-- creaet warehouse schema

USE ROLE SYSADMIN;

USE DATABASE project_hr;

CREATE SCHEMA IF NOT EXISTS warehouse;

SHOW SCHEMAS IN DATABASE project_hr;

-- grant privileges to work on warehouse schema
USE ROLE securityadmin;

GRANT ROLE dlt_dev_role TO ROLE dbt_dev_role;

SHOW ROLES;

SHOW GRANTS TO ROLE dbt_dev_role; --privileges and roles granted to this role, for existing objects
SHOW GRANTS OF ROLE dlt_dev_role; --users granted this role



-- note that job_ads_dlt_role already has the usage privilege on database job_ads
GRANT USAGE,
CREATE TABLE,
CREATE VIEW ON SCHEMA project_hr.warehouse TO ROLE dbt_dev_role; 

-- grant CRUD and select tables and views
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA project_hr.warehouse TO ROLE dbt_dev_role;

GRANT SELECT ON ALL VIEWS IN SCHEMA project_hr.warehouse TO ROLE dbt_dev_role;

-- grant CRUD and select on future tables and views
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA project_hr.warehouse TO ROLE dbt_dev_role;

GRANT SELECT ON FUTURE VIEWS IN SCHEMA project_hr.warehouse TO ROLE dbt_dev_role;

-- test on the new role

USE ROLE dbt_dev_role;


SELECT * FROM project_hr.staging.project_job_ads LIMIT 10;

SHOW GRANTS ON SCHEMA project_hr.warehouse;

USE SCHEMA job_ads.warehouse;

SHOW GRANTS TO ROLE dbt_dev_role; --privileges and roles granted to this role, for existing objects
