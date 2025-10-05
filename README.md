# Snowflake Share Consumer

SQL scripts for setting up and querying a Snowflake consumer account that accesses shared data from a provider account.

## Overview

This repository demonstrates how to consume data shared via Snowflake's secure data sharing feature. The scripts set up a consumer database that references shared data from the provider account `ZLMNHTD.QS08465`.

## Prerequisites

- Access to a Snowflake consumer account
- Permissions to create databases and warehouses
- Inbound share `SALES_SHARE` from provider account `ZLMNHTD.QS08465`

## Setup

### 1. Create Database from Share

Run `01_create_db_from_share.sql` to create the initial database:

```sql
-- View available shares
SHOW SHARES;

-- Create database from share
CREATE DATABASE SHARED_SALES_DATA
    FROM SHARE ZLMNHTD.QS08465.SALES_SHARE;

-- Query shared data
USE DATABASE SHARED_SALES_DATA;
SELECT * FROM PUBLIC.CUSTOMER_ORDERS;
```

### 2. Complete Consumer Setup

Run `02_queries_in_shared_account.sql` for a full setup including warehouse creation:

```sql
-- Create database from share
CREATE DATABASE SALES_SHARED_DB FROM SHARE ZLMNHTD.QS08465.SALES_SHARE;

-- Grant permissions
GRANT IMPORTED PRIVILEGES ON DATABASE SALES_SHARED_DB TO ROLE ACCOUNTADMIN;

-- Create warehouse (required for reader accounts)
CREATE WAREHOUSE READER_WH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60;

-- Query shared data
USE WAREHOUSE READER_WH;
SELECT * FROM PUBLIC.CUSTOMER_ORDERS;
```

## Shared Data

The provider shares the following objects:

- **Schema**: `PUBLIC`
- **Table**: `CUSTOMER_ORDERS`

## Important Notes

- **Reader Accounts**: If using a reader account, you must create a virtual warehouse as they don't have compute resources by default
- **Permissions**: Use `GRANT IMPORTED PRIVILEGES` for shared databases since you don't own the objects
- **Database Names**: The two scripts use different database names (`SHARED_SALES_DATA` vs `SALES_SHARED_DB`) - use whichever fits your naming convention

## Usage

Execute the scripts in a Snowflake worksheet or via SnowSQL:

```bash
snowsql -f 01_create_db_from_share.sql
snowsql -f 02_queries_in_shared_account.sql
```

## Inspecting Shared Data

```sql
-- View schemas in shared database
SHOW SCHEMAS IN DATABASE SALES_SHARED_DB;

-- View tables in schema
SHOW TABLES IN SCHEMA PUBLIC;

-- View all objects
SHOW OBJECTS IN DATABASE SALES_SHARED_DB;
```
