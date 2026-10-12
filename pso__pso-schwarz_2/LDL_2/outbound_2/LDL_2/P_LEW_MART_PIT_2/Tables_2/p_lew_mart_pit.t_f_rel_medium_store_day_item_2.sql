/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_REL_MEDIUM_STORE_DAY_ITEM_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Basis Fact Relationship Table Medium Day Item_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-25 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.3  2022-03-30 Andreas Kurz		Removed some NOT NULLs
#  1.4  2022-03-31 Mike Davis		Add in some item_2 specific information
#  1.5  2022-04-01 Andreas Kurz     Add Real Promotion Action Type FGs etc.
#  1.6  2022-04-05 Mike Davis       Set real stuff to default -1 until figure out how to do this
#  1.7  2022-04-08 Mike Davis       Minor change: reject_fg before reject_reason_id
#  1.8	2022-06-24 Nikolai Toknov	Add CLUSTER BY (CLIENT_ID, DAY_DT)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  6.0	2024-08-11 Andreas Kurz		Added ACTION_SUBTYPE_ID
#-------------------------------------------------------------------------------
*/
/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID
ORIG_ITEM_MSTR_NR
REPORTING_ADV_PERIOD_FG

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM_2 ADD ACTION_SUBTYPE_ID					INTEGER 					DEFAULT -1 									COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | PD_2 ::= 3 | -1 ::= N/A | -2 ::= Total PV)'

CREATE TABLE LDL.P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM_BCK AS CLONE P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM_2;
ALTER TABLE T_F_REL_MEDIUM_STORE_DAY_ITEM_2 RENAME COLUMN  REAL_PROMOTION_NP_FG TO REAL_NP_FG;

*/


-- ADV_PERIOD_MSTR_ID					INTEGER						DEFAULT -1 									COMMENT 'Advertising Period - Frontend CROSS JOIN',
 -- ),

-- REPORTING_ADV_PERIOD_FG				INTEGER AS (
 -- AKU added 2022-04-01 added Real Promotion Action Type FGs

-- ADV_WEEK_MSTR_ID					INTEGER						DEFAULT -1 									COMMENT 'Advertising Week - Frontend CROSS JOIN',

-- AKU 2022-01-27 adding cnt-fg which could be used to apply sum agg function

-- IFF((DAY_DT >= REPORTING_ADV_PERIOD_START_DAY_DT) AND (DAY_DT <= REPORTING_ADV_PERIOD_END_DAY_DT), 1, 0)

-- AKU added Adv.Week Start and 		End Date
 -- MEDIUM_GRP_MSTR_SID					INTEGER						DEFAULT -1,
 -- Technical fields

-- ORIG_ITEM_MSTR_NR					INTEGER		 															COMMENT 'Special MSTR CROSS JOIN criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',

-- MEDIUM_MSTR_SID						INTEGER						DEFAULT -1 									COMMENT 'Medium MSTR surrogate Key',
 CREATE TABLE
IF NOT EXISTS ldl_p_lew_mart_pit.t_f_rel_medium_store_day_item_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. AT==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_2'),
week_id INTEGER DEFAULT 888853
OPTIONS(description='Week (based on ISO) of Sales. Added to have better CROSS JOIN options in agg_jobs'),
month_id INTEGER DEFAULT 888812 OPTIONS(description='Month of Sales_2'),
year_id INTEGER DEFAULT 8888 OPTIONS(description='Year (based on ISO) of Sales_2'),
adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Advertising Week'),
adv_week_start_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='End Date of Adv.-Week'),
adv_week_end_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Start Date of Adv-Week'),
adv_period_id INTEGER OPTIONS(description='Advertising Period'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Start day of Advertisment Period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='End day of Advertisment Period'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='REPORTING_ADV_PERIOD_START_DAY_DT'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='End day of Advertisement Period'),
medium_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the medium (simply the channel_sid).'),
medium_grp_sid INTEGER DEFAULT - 1 OPTIONS(description='Unique system ID, sid, for the medium group.'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Surrogate ID for Store L1 '),
store_name STRING(16777216) OPTIONS(description='Store name'),
orig_store_nr INTEGER OPTIONS(description='Original Store Number / code from Wawi'),
warehouse_sid INTEGER DEFAULT - 1 OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
item_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the item_2 variant that is active (may include main item_2 sids also).'),
orig_item_nr INTEGER
OPTIONS(description='Item_2 business identifier. NaN := National Article Number CORE_AC.v_item_2: TRYCAST(Coalesce(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr) AS INTEGER )'),
sub_item_grp_sid INTEGER DEFAULT - 1 OPTIONS(description='Sid for item_2 sub group. (UWG)'),
item_grp_int_sid INTEGER DEFAULT - 1 OPTIONS(description='Sid for item_2 international group. (WGI)'),
action_type_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.'),
item_fa_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / indicator telling Item_2 is FA Food Action. iff(ACTION_TYPE_ID=3,1::INTEGER ,0::INTEGER )'),
item_nf_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / indicator telling that item_2 is NF None-Food. iff(ACTION_TYPE_ID=2,1::INTEGER ,0::INTEGER )'),
item_pv_wawi_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling item_2 WaWi-PV'),
item_pv_npps_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / indicator telling item_2 Promotion Designer (NPPS)'),
item_pv_lp_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling item_2 LidlPlus (LP)'),
item_np_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / indicator telling item_2 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )'),
real_action_type_id INTEGER DEFAULT - 1
OPTIONS(description='Real (TBD) Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.'),
real_promotion_fa_fg INTEGER DEFAULT - 1
OPTIONS(description='Real (TBD) Flag / indicator telling Item_2 is FA Food Action. iff(ACTION_TYPE_ID=3,1::INTEGER ,0::INTEGER )'),
real_promotion_nf_fg INTEGER DEFAULT - 1
OPTIONS(description='Real (TBD) Flag / indicator telling that item_2 is NF None-Food. iff(ACTION_TYPE_ID=2,1::INTEGER ,0::INTEGER )'),
real_promotion_pv_lp_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item_2 is PV_LP'),
real_promotion_pv_wawi_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item_2 is PV_WAWI'),
real_promotion_pv_npps_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item_2 is PV_NPPS'),
real_np_fg INTEGER DEFAULT - 1
OPTIONS(description='Real (TBD) Flag / indicator telling item_2 is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )'),
cnt_fg INTEGER DEFAULT 1 OPTIONS(description='Artfical column, which could be used to apply an sum agg function.'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, day_dt, item_sid, medium_sid, store_sid, action_type_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Basis Fact Relationship Table Medium Store Item_2 Day');