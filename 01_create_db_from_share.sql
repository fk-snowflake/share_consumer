-- Switch to consumer account
-- Display all inbound shares available to this consumer account
-- Shows share name, provider account, database name, and share type
SHOW SHARES;

-- Create a local database that references the shared data from the provider
-- Database name: SHARED_SALES_DATA (local reference name)
-- Provider: ZLMNHTD.QS08465
-- Share name: SALES_SHARE
-- This creates a read-only database that accesses shared objects without copying data
CREATE DATABASE SHARED_SALES_DATA
    FROM SHARE ZLMNHTD.QS08465.SALES_SHARE;

-- Set the active database context to the newly created shared database
USE DATABASE SHARED_SALES_DATA;

-- Query all rows from the CUSTOMER_ORDERS table in the PUBLIC schema
-- Note: Requires an active warehouse to execute SELECT queries
SELECT * FROM PUBLIC.CUSTOMER_ORDERS;