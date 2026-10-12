/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_REGION_STORE_CNT
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Basis Fact Table Region_1 Store Counts
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-24 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0  2022-11-23 Nikolai Toknov	Reworked the structure
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
ADV_WEEK_MSTR_ID
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_region_store_cnt_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
warehouse_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
a_level_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Aggregation Level of the KPI'),
total_store_cnt BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Store Count of this Day (only open Stores which have sales_1 more than the limits on RECEIPT_CNT and TURNOVER_NET_VAL)'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, adv_week_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, adv_week_id
OPTIONS(description='Basis Fact Table Region_1 Store Counts');