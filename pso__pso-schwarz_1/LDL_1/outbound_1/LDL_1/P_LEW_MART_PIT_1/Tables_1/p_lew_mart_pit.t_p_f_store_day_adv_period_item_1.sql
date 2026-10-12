/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_STORE_DAY_ADV_PERIOD_ITEM_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table Delivery to WH
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0  2021-10-20 Aparna Rayanki		Initial version
#	1.1  2021-10-25 Aparna Rayanki		Removed MSTR related columns and descriptions
#	1.2  2022-01-21 Andreas Kurz		Reworked the structure
#	1.3  2022-04-24	Nikolai Toknov		Add columns REPORT_ADV_PERIOD_START_DAY_DT,REPORT_ADV_PERIOD_END_DAY_DT
#	1.4  2022-04-27 Nikolai Toknov		Rename columns: REPORT_ADV_PERIOD_ -> REPORTING_ADV_PERIOD_
#	1.5  2022-04-27 Nikolai Toknov		Add REPORTING_ADV_PERIOD_FG
#	1.6	 2022-07-06 Nikolai Toknov		Change column ADV_THEME_NATIONAL_SID,ADV_THEME_INTERNATIONAL_SID -> THEME_GID,THEME_GRP_SID 
#   1.7	 2023-03-16 Nikolai Toknov		INTEGER /NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INTEGER  - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#   1.8  2023-09-05 Andreas Kurz		Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#   4.0  2023-11-06 Nikolai Toknov		Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#	4.1  2024-12-21 Andreas Kurz		Removed ACTION_SUBTPYE_ID
#-------------------------------------------------------------------------------
*/

/*
VC:
ORIG_ITEM_MSTR_NR
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
THEME_GRP_NAT_MSTR_SID
THEME_GRP_NAT_CAT_MSTR_SID
THEME_GRP_INT_MSTR_SID
REPORTING_ADV_PERIOD_FG

ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_1 ADD ACTION_SUBTYPE_ID INTEGER DEFAULT -1;
UPDATE LDL.P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_1
SET ACTION_SUBTYPE_ID = ACTION_TYPE_ID 
WHERE DELETED_FG = 0 AND REJECT_FG = 0
*/


-- THEME_GRP_INT_MSTR_SID					INTEGER		 															COMMENT '[VC] MSTR surrogate Key : Theme Group INTEGER ',

-- IFF((DAY_DT >= REPORTING_ADV_PERIOD_START_DAY_DT) AND (DAY_DT <= REPORTING_ADV_PERIOD_END_DAY_DT), 1, 0)

-- THEME_GRP_NAT_MSTR_SID					INTEGER		 															COMMENT '[VC] MSTR surrogate Key : Theme Group NAT',
 -- ),

-- THEME_GRP_NAT_CAT_MSTR_SID				INTEGER		 															COMMENT 'MSTR surrogate Key : Theme Group NAT Category',

-- aku debugging purposes
 -- Technical fields
 -- REPORTING_ADV_PERIOD_FG					INTEGER AS (
 CREATE TABLE IF NOT EXISTS
ldl_p_lew_mart_pit.t_p_f_store_day_adv_period_item_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_1 Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History'),
sub_item_grp_sid INTEGER DEFAULT - 1,
item_grp_int_sid INTEGER DEFAULT - 1,
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_1'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER DEFAULT - 1 NOT NULL,
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start day of Advertisement Period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End day of Advertisement Period'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
warehouse_sid INTEGER DEFAULT - 1 OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse NUMBER  / code from Wawi'),
theme_grp_nat_sid INTEGER OPTIONS(description='FK to Theme Group NAT'),
theme_grp_int_sid INTEGER OPTIONS(description='FK to Theme Group INTEGER '),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 OPTIONS(description='FK to Theme Group NAT Category'),
action_type_id INTEGER DEFAULT - 1,
item_fa_fg INTEGER DEFAULT 0,
item_nf_fg INTEGER DEFAULT 0,
item_pv_fg INTEGER DEFAULT 0,
item_np_fg INTEGER DEFAULT 0,
item_grp_int_name STRING(16777216),
wawi_dat_adv DATE,
adp_campaign_elem_start_dt DATE,
adp_real_campaign_elem_end_dt DATE,
promotion_start_dt DATE DEFAULT DATE '8888-12-31',
real_promotion_end_dt DATE DEFAULT DATE '8888-12-31',
promotion_end_dt DATE DEFAULT DATE '8888-12-31',
calc_promotion_end_dt_fg INTEGER DEFAULT - 1,
price_active_from_dt DATE DEFAULT DATE '8888-12-31',
real_price_active_to_dt DATE DEFAULT DATE '8888-12-31',
price_active_to_dt DATE DEFAULT DATE '8888-12-31',
calc_price_active_to_dt_fg INTEGER DEFAULT - 1,
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
PRIMARY KEY (client_id, day_dt, store_sid, item_sid, adv_period_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Basis Pre Fact Table on Store Day Item_1');