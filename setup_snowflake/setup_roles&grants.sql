USE ROLE USERADMIN;
SELECT CURRENT_USER;

-- ======================================================
-- 1️⃣ Create roles
-- ======================================================
CREATE ROLE IF NOT EXISTS dlt_dev_role;
CREATE ROLE IF NOT EXISTS dlt_readonly_role;
CREATE ROLE IF NOT EXISTS marts_streamer_role;

-- ======================================================
-- 2️⃣ Assign roles to users
-- ======================================================
USE ROLE SECURITYADMIN;

-- Dev role assignments
GRANT ROLE dlt_dev_role TO USER freja_user;
GRANT ROLE dlt_dev_role TO USER thorbjorn_user;
GRANT ROLE dlt_dev_role TO USER fredrik_user;

-- Read-only role assignments (if needed, add users here)

-- Streamer role assignments
GRANT ROLE marts_streamer_role TO USER streamer_boy;
GRANT ROLE marts_streamer_role TO USER frey;
GRANT ROLE marts_streamer_role TO USER thorbjorn_user;
GRANT ROLE marts_streamer_role TO USER fredrik_user;

-- ======================================================
-- 3️⃣ elevated all users to ACCOUNTADMIN
-- ======================================================
USE ROLE ACCOUNTADMIN;
GRANT ROLE ACCOUNTADMIN TO USER fredrik_user;
GRANT ROLE ACCOUNTADMIN TO USER thorbjorn_user;

-- ======================================================
-- 4️⃣ Grant warehouse usage
-- ======================================================
USE ROLE SECURITYADMIN;

GRANT USAGE ON WAREHOUSE group_wh TO ROLE dlt_dev_role;
GRANT USAGE ON WAREHOUSE group_wh TO ROLE dlt_readonly_role;
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE marts_streamer_role;
GRANT USAGE ON WAREHOUSE group_wh TO ROLE marts_streamer_role;

-- ======================================================
-- 5️⃣ Grant database usage
-- ======================================================
GRANT USAGE ON DATABASE project_hr TO ROLE dlt_dev_role;
GRANT USAGE ON DATABASE project_hr TO ROLE dlt_readonly_role;
GRANT USAGE ON DATABASE project_hr TO ROLE marts_streamer_role;

-- ======================================================
-- 6️⃣ Grant schema usage
-- ======================================================
-- Staging schema
GRANT USAGE ON SCHEMA project_hr.staging TO ROLE dlt_dev_role;
GRANT USAGE ON SCHEMA project_hr.staging TO ROLE dlt_readonly_role;
GRANT CREATE TABLE ON SCHEMA project_hr.staging TO ROLE dlt_dev_role;

-- Marts schema
GRANT USAGE ON SCHEMA project_hr.marts TO ROLE marts_streamer_role;

-- ======================================================
-- 7️⃣ Table & view privileges
-- ======================================================
-- Dev role → full CRUD in staging
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA project_hr.staging TO ROLE dlt_dev_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA project_hr.staging TO ROLE dlt_dev_role;

-- Read-only role → read-only in staging
GRANT SELECT ON ALL TABLES IN SCHEMA project_hr.staging TO ROLE dlt_readonly_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA project_hr.staging TO ROLE dlt_readonly_role;
GRANT SELECT ON FUTURE TABLES IN DATABASE project_hr TO ROLE dlt_readonly_role;

-- Streamer role → read-only in marts
GRANT SELECT ON ALL TABLES IN SCHEMA project_hr.marts TO ROLE marts_streamer_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA project_hr.marts TO ROLE marts_streamer_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA project_hr.marts TO ROLE marts_streamer_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA project_hr.marts TO ROLE marts_streamer_role;



-- ======================================================
-- 8️⃣ Validation
-- ======================================================
SHOW ROLES;
SHOW GRANTS TO ROLE dlt_dev_role;
SHOW GRANTS TO ROLE dlt_readonly_role;
SHOW GRANTS TO ROLE marts_streamer_role;


--- TEST QUERY -------------------------------
SELECT * FROM project_hr.marts.marts_bygg;
SELECT * FROM project_hr.warehouse.dim_occupation;


