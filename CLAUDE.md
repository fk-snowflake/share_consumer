# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains Snowflake SQL scripts for configuring and querying a **consumer account** that accesses data shared from a provider account via Snowflake Data Sharing.

## Architecture

### Data Sharing Pattern
- **Provider Account**: `ZLMNHTD.QS08465` shares data via `SALES_SHARE`
- **Consumer Account**: Creates local database from the share and queries it
- **Shared Objects**: Primarily the `PUBLIC.CUSTOMER_ORDERS` table

### Script Execution Order

1. **01_create_db_from_share.sql**: Initial setup - creates database from share
2. **02_queries_in_shared_account.sql**: Complete consumer setup with warehouse creation and querying

## Key Snowflake Concepts

### Shared Database Creation
```sql
CREATE DATABASE <db_name> FROM SHARE <provider_account>.<share_name>;
```

### Reader Account Considerations
- Reader accounts have no compute resources by default
- Must create a virtual warehouse before querying shared data
- The `READER_WH` warehouse is created with XSMALL size and 60-second auto-suspend

### Permission Management
- Use `GRANT IMPORTED PRIVILEGES` to grant access to shared databases
- Imported privileges are required because you don't own the shared objects

## Common Commands

### View Available Shares
```sql
SHOW SHARES;
```

### Inspect Shared Database
```sql
SHOW SCHEMAS IN DATABASE <shared_db_name>;
SHOW TABLES IN SCHEMA <schema_name>;
SHOW OBJECTS IN DATABASE <shared_db_name>;
```

### Query Shared Data
Requires an active warehouse:
```sql
USE WAREHOUSE READER_WH;
SELECT * FROM <schema>.<table>;
```

## Database Names
The scripts use two variations of database names:
- `SHARED_SALES_DATA` (in 01_create_db_from_share.sql)
- `SALES_SHARED_DB` (in 02_queries_in_shared_account.sql)

Be aware of this inconsistency when working with these scripts.
