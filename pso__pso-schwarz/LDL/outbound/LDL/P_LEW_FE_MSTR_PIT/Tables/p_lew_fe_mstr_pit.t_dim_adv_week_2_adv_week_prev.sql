/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_WEEK_2_ADV_WEEK_PREV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-23 Mike Davis      Checks, formatting, FK support (now removed)
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA, added COMMIT
#  2.0	2022-04-12 Nikolai Toknov  Changing the script for DevOps
#  2.1  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
ADV_WEEK_DESCR
RLTD_ADV_WEEK_MSTR_ID
RLTD_ADV_WEEK_DESCR
RLTD_ADV_WEEK_SDESCR
RLTD_ADV_WEEK_LDESCR

*/


-- ADV_WEEK_DESCR				STRING 																COMMENT 'Description of Adv.-Week',

-- RLTD_ADV_WEEK_SDESCR		STRING 																COMMENT 'Short Description of previous / related Adv.-Week',

-- RLTD_ADV_WEEK_DESCR			STRING 																COMMENT 'Description of previous / related Adv.-Week',

-- Technical fields
 -- AKU added 2022-05-22

-- RLTD_ADV_WEEK_LDESCR		STRING 																COMMENT 'Long Description of previous / related Adv.-Week',
 CREATE
TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_dim_adv_week_2_adv_week_prev (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT==1'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
adv_week_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Adv.Week ID'),
rltd_adv_week_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Prev. Adv.Week ID'),
rltd_adv_week_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Week Start			DATE of previous / related Adv.-Week'),
rltd_adv_week_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Week End			DATE of previous / related Adv.-Week'),
diff_adv_week_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Difference in Adv.-Weeks between Adv.Week and Previous Adv.-Week e.g. 202124 | 202122 à (-2)'),
nearest_rltd_adv_week_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / Indicator Frontend relevant to simple filter all reltated Adv-Weeks. '),
related_type_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='The type ID of the related week comparison'),
related_type_descr STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='The German type description of the related week  comparison, to show in the reporting'),
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
PRIMARY KEY (client_id, adv_week_id, rltd_adv_week_id, related_type_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Dimension table for Adv.-Week');