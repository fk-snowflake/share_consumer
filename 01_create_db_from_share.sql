-- Switch to consumer account
-- List available inbound shares
SHOW SHARES;

-- Create database from share
CREATE DATABASE SHARED_SALES_DATA
    FROM SHARE ZLMNHTD.QS08465.SALES_SHARE;

-- Query shared data
USE DATABASE SHARED_SALES_DATA;
SELECT * FROM PUBLIC.CUSTOMER_ORDERS;