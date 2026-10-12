/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_PSNF_STORE_ADV_PERIOD_ITEM_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0		2023-07-25 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/


-- FAKTEN / MEASURES / KPIs
 -- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_psnf_store_adv_period_item_1
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_1 Variant (Case Size)'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start day of the extended period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End day of the extended period'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start day of Advertisement Period'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End day of Advertisement Period'),
overlap_period_fg INTEGER DEFAULT 0 OPTIONS(description='If periods overlap'),
cut_period_fg INTEGER DEFAULT 0
OPTIONS(description='If periods overlap and  start date difference is greater than 7 days and which have an overlap'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
delivered_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of items to be promoted ( stock on the day before the extended period starts and delivery to the store during the period). '),
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
PRIMARY KEY (client_id, store_sid, orig_item_nr, reporting_adv_period_start_day_dt) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Information about promotional periods in stores');