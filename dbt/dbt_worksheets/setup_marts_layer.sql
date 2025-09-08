-- We use marts layers to serve the data

USE ROLE SYSADMIN;

USE DATABASE project_hr;

CREATE SCHEMA IF NOT EXISTS marts;

SHOW SCHEMAS IN DATABASE project_hr;

USE ROLE securityadmin;

GRANT USAGE,
CREATE TABLE,
CREATE VIEW ON SCHEMA project_hr.marts TO ROLE dbt_dev_role;

-- grant CRUD and select tables and views
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA project_hr.marts TO ROLE dbt_dev_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA project_hr.marts TO ROLE dbt_dev_role;

-- grant CRUD and select on future tables and views
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA project_hr.marts TO ROLE dbt_dev_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA project_hr.marts TO ROLE dbt_dev_role;

USE ROLE dbt_dev_role;

SHOW GRANTS ON SCHEMA project_hr.marts;

-- manual test
USE SCHEMA project_hr.marts;
CREATE TABLE test (id INTEGER);
SHOW TABLES;
DROP TABLE TEST;