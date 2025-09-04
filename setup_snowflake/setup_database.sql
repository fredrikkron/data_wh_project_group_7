USE ROLE SYSADMIN;

-- Warehouse (compute resources)
CREATE WAREHOUSE group_wh
WITH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  COMMENT = 'Warehouse for group project.';


-- Database
CREATE DATABASE project_HR;

-- Schemas
CREATE SCHEMA project_HR.staging;

