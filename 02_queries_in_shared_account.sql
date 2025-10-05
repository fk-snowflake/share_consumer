-- Switch to consumer account
-- Display all inbound shares available to this consumer account
-- Returns share name, kind, database name, and provider account information
SHOW SHARES;

-- Create a local database that references the shared data from the provider
-- Database name: SALES_SHARED_DB (local reference name)
-- Provider: ZLMNHTD.QS08465
-- Share name: SALES_SHARE
-- Creates a read-only database without copying data
CREATE DATABASE SALES_SHARED_DB FROM SHARE ZLMNHTD.QS08465.SALES_SHARE;

-- Display all databases in the current account to verify creation
SHOW DATABASES;

-- Grant imported privileges on the shared database to ACCOUNTADMIN role
-- IMPORTED PRIVILEGES is required for shared databases since objects are owned by provider
-- Allows the role to query objects within the shared database
GRANT IMPORTED PRIVILEGES ON DATABASE SALES_SHARED_DB TO ROLE ACCOUNTADMIN;

-- Set the active database context to the shared database
USE DATABASE SALES_SHARED_DB;

-- Display all schemas available in the shared database
-- Shows what schemas the provider has shared
SHOW SCHEMAS;

-- Display all tables in the PUBLIC schema of the shared database
SHOW TABLES IN SCHEMA PUBLIC;

-- Display all objects (tables, views, etc.) in the PUBLIC schema
-- More comprehensive than SHOW TABLES as it includes all object types
SHOW OBJECTS IN SCHEMA PUBLIC;

-- Display all objects across all schemas in the shared database
-- Provides a complete inventory of shared objects
SHOW OBJECTS IN DATABASE SALES_SHARED_DB;

-- Create a virtual warehouse for query execution
-- Reader accounts don't have compute resources by default
-- Warehouse size: XSMALL (smallest size, suitable for light workloads)
-- Auto-suspend: 60 seconds (warehouse suspends after 1 minute of inactivity to save costs)
CREATE WAREHOUSE READER_WH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60;

-- Display all warehouses in the account to verify creation
SHOW WAREHOUSES;

-- Set the active warehouse context to the newly created warehouse
-- All subsequent queries will use this warehouse for compute
USE WAREHOUSE READER_WH;

-- Query all rows from the CUSTOMER_ORDERS table in the PUBLIC schema
-- Executes using the READER_WH warehouse
SELECT * FROM PUBLIC.CUSTOMER_ORDERS;
