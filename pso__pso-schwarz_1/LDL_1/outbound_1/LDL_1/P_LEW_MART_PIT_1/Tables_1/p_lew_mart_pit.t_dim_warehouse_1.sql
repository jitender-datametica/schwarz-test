/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_WAREHOUSE
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Warehouse
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-11 Massimo Morelli  Initial version
#  2.0	2022-07-13 Nikolai Toknov  	Changing the script for DevOps
#  2.1  2022-07-17 Andreas Kurz		Removed STRING(150) --> STRING
#  2.1  2024-04-15 Nikolai Toknov   Fix issue DDLvsGIT
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
WAREHOUSE_MSTR_SID
WAREHOUSE_MSTR_GID
ORIG_WH_NR_NAME
*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_warehouse_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Sid for warehouse'),
warehouse_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse NUMBER  / code from Wawi'),
region_type_id STRING(3) OPTIONS(description='Standard (STD) or Individual region_1 (IND)'),
region_type_descr STRING(16777216) OPTIONS(description='Region_1 Type Description'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Versioning: valid from'),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Versioning: valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Versioning: version nr'),
current_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Versioning: current flag: 1-->current version ; 0-->not current version'),
scd_key_md STRING(32)
OPTIONS(description='Slowly Changing Dimension (SCD) MD Key. Tracking the version relevant columns'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, warehouse_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, warehouse_sid
OPTIONS(description='Dimension table for Region_1');