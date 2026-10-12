/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_PSNF_STORE_DAY_ADV_PERIOD_ITEM_1
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0  2023-07-12 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/
/*
DROP TABLE LDL.P_LEW_MART_PIT.T_P_F_PSNF_STORE_DAY_ADV_PERIOD_ITEM_1;
*/


-- CALC_PROMOTION_END_DT_FG				INTEGER DEFAULT -1,
 -- ACTION_TYPE_ID							INTEGER						DEFAULT -1,

-- REAL_PROMOTION_END_DT					DATE						DEFAULT DATE '8888-12-31',
 /* NOT NULL */ /* NOT NULL */
-- SUB_ITEM_GRP_SID						INTEGER						DEFAULT -1,
 /* NOT NULL */ -- 

-- PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_PERIOD_ID, DELETED_FG)

-- ITEM_GRP_INT_SID						INTEGER						DEFAULT -1,
 /* NOT NULL */ /* NOT NULL */ /* NOT NULL */
-- (ORIG_ITEM_NR * 100) + CLIENT_ID
 -- ITEM_NP_FG								INTEGER DEFAULT 0,
 -- ITEM_PV_FG								INTEGER DEFAULT 0,

-- ORIG_STORE_NR							INTEGER		 															COMMENT 'Orig Store NUMBER',

-- PROMOTION_END_DT						DATE						DEFAULT DATE '8888-12-31',
 -- aku debugging purposes
 /* NOT NULL */ -- ,

-- STORE_SID								INTEGER			/*NOT NULL*/	DEFAULT -1 									COMMENT 'Unique key Region_1 surrogate key',

/* NOT NULL */ /* NOT NULL */ -- PROMOTION_START_DT						DATE						DEFAULT DATE '8888-12-31',
 /* NOT NULL */
-- ORIG_ITEM_MSTR_NR						INTEGER		 AS (
 -- )			DEFAULT -1,

-- STORE_NAME								STRING 																COMMENT 'Store Name',
 -- ITEM_FA_FG								INTEGER DEFAULT 0,

-- Technical fields
 /* NOT NULL */ /* NOT NULL */ /* NOT NULL */ -- ITEM_NF_FG								INTEGER DEFAULT 0,

/* NOT NULL */ -- ADV_WEEK_MSTR_ID						INTEGER			/*NOT NULL*/	DEFAULT -1,
 CREATE TABLE IF NOT EXISTS
ldl_p_lew_mart_pit.t_p_f_psnf_store_day_adv_period_item_1 (
client_id INTEGER DEFAULT - 1 OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_sid INTEGER DEFAULT - 1 OPTIONS(description='Item_1 Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History'),
day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Day of Sales_1'),
adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Advertising Week'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Start day of Advertisement Period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='End day of Advertisement Period'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31',
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31',
overlap_fg INTEGER DEFAULT 0
OPTIONS(description='If periods overlap and starts periods differ by equal or less than 7 days (set for the whole period)'),
cut_day_fg INTEGER DEFAULT 0
OPTIONS(description='Days are marked for periods whose start date difference is greater than 7 days and which have an overlap'),
campaign_elem_sid INTEGER DEFAULT - 1,
adp_campaign_elem_start_dt DATE,
adp_real_campaign_elem_end_dt DATE,
reject_comments STRING(16777216),
reject_reason_id INTEGER DEFAULT - 1 OPTIONS(description='Link to DQ Reject Reason Codes'),
reject_fg INTEGER DEFAULT 0
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
source_system_id INTEGER DEFAULT 0 OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME)
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 OPTIONS(description='Technical Field ELT / ABInitio Process ID')
) CLUSTER BY client_id, day_dt
OPTIONS(description='Basis Pre Fact Table on Store Day Item_1');