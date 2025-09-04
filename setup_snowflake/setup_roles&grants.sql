USE ROLE USERADMIN;
SELECT CURRENT_USER;

CREATE ROLE dlt_dev_role;
CREATE ROLE dlt_readonly_role;

-- switch to an appropriate role to grant privileges to role & grant role to user
USE ROLE SECURITYADMIN;

GRANT ROLE dlt_dev_role TO USER freja_user;
GRANT ROLE dlt_dev_role TO USER thorbjorn_user;
GRANT ROLE dlt_dev_role TO USER fredrik_user;


GRANT USAGE ON WAREHOUSE group_wh TO ROLE dlt_dev_role;
GRANT USAGE ON DATABASE project_HR TO ROLE dlt_dev_role;
GRANT USAGE ON SCHEMA project_HR.staging to ROLE dlt_dev_role;

USE ROLE ACCOUNTADMIN;

-- Grant ACCOUNTADMIN role to users
GRANT ROLE ACCOUNTADMIN TO USER fredrik_user;
GRANT ROLE ACCOUNTADMIN TO USER thorbjorn_user;



USE ROLE SECURITYADMIN;
-- ======================================
-- 1️⃣ Warehouse access
-- ======================================
GRANT USAGE ON WAREHOUSE group_wh TO ROLE dlt_dev_role;
GRANT USAGE ON WAREHOUSE group_wh TO ROLE dlt_readonly_role;

-- ======================================
-- 2️⃣ Database access
-- ======================================
GRANT USAGE ON DATABASE project_HR TO ROLE dlt_dev_role;
GRANT USAGE ON DATABASE project_HR TO ROLE dlt_readonly_role;

-- ======================================
-- 3️⃣ Schema access
-- ======================================
GRANT USAGE ON SCHEMA project_HR.staging TO ROLE dlt_dev_role;
GRANT USAGE ON SCHEMA project_HR.staging TO ROLE dlt_readonly_role;


-- ======================================
-- 4️⃣ Table privileges
-- Dev role → full CRUD
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA project_HR.staging TO ROLE dlt_dev_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA project_HR.staging TO ROLE dlt_dev_role;


-- Readonly role → read-only
GRANT SELECT ON ALL TABLES IN SCHEMA project_HR.staging TO ROLE dlt_readonly_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA project_HR.staging TO ROLE dlt_readonly_role;
GRANT SELECT ON FUTURE TABLES IN DATABASE project_HR TO ROLE dlt_readonly_role;













