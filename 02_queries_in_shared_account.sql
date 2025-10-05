-- Switch to consumer account
-- List available inbound shares
SHOW SHARES;

-- Create database from the shared data
CREATE DATABASE SALES_SHARED_DB FROM SHARE ZLMNHTD.QS08465.SALES_SHARE;

SHOW DATABASES;

-- Grant usage on the shared database to roles (adjust role name as needed)
GRANT IMPORTED PRIVILEGES ON DATABASE SALES_SHARED_DB TO ROLE ACCOUNTADMIN;

-- Switch to the shared database
USE DATABASE SALES_SHARED_DB;

-- View available schemas in the shared database
SHOW SCHEMAS;

-- View tables in a specific schema (replace SCHEMA_NAME with actual schema)
SHOW TABLES IN SCHEMA PUBLIC;
SHOW OBJECTS IN SCHEMA PUBLIC;

-- View all objects in the shared database
SHOW OBJECTS IN DATABASE SALES_SHARED_DB.PUBLIC;


-- Note: Reader accounts don't have compute resources
-- Provider must create virtual warehouse for them
CREATE WAREHOUSE READER_WH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60;

USE WAREHOUSE READER_WH;

SELECT * FROM PUBLIC.CUSTOMER_ORDERS;
