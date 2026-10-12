/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_WAWI_PV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for periods
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-08-05 Andreas Kurz		Initial version
#  1.1  2024-11-14 Andreas Kurz		Rework Structrue based on Technisches Concept 
#									S2T_Mapping_Increment_2.1_20241028
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;	
*/


-- PCH_BASELINE_FG 						INTEGER COMMENT 'Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)',

-- Technical fields
 -- PCH_DAY_PRICEGROUP_FG					INTEGER COMMENT 'PV Tag Preisschienen',
 CREATE TABLE IF NOT EXISTS
ldl_p_lew_mart_pit.t_p_f_store_day_adv_period_item_adv_wawi_pv (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales'),
store_sid INTEGER NOT NULL OPTIONS(description='Unique key Region surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
warehouse_sid INTEGER OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER NOT NULL
OPTIONS(description='WaWi-Werbe-PV Period on Country Level. Advertising Period. Min/Max Rule applied. Long Period Spliiting Applied'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='WaWi-Werbe-PV Period on Country Level. Start DATE of the Adv.Period. Min/Max Rule applied. Long Period Spliiting Applied'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='WaWi-Werbe-PV Period on Country Level. End DATE of the Adv.Period. Min/Max Rule applied. Long Period Spliiting Applied'),
adv_length_of_period INTEGER
OPTIONS(description='WaWi-Werbe-PV Period on Country Level. Length Advertisement Period in Days. Min/Max Rule applied. Long Period Spliiting Applied'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start day of Advertisement Period'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End day of Advertisement Period'),
reporting_adv_period_fg INTEGER DEFAULT 1
OPTIONS(description='Indicator [0,1] If day between periods start / end then 1'),
pch_period_start_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='WaWi-Werbe-PV Period on Store Level. Start day of PriceChange Period, GAP Parameter Applied'),
pch_period_end_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='WaWi-Werbe-PV Period on Store Level. End day of PriceChange Period, GAP Parameter Applied'),
pch_length_of_period INTEGER
OPTIONS(description='WaWi-Werbe-PV Period on Store Level. Length PriceChange Period in Days, GAP Parameter Applied'),
spliitted_wawi_pv_period_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Indicator if a WaWi-Werbe-PV Period was splitted due to an longer Period'),
item_sid INTEGER NOT NULL OPTIONS(description='Item Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item NaN (National Artikel Nummer) Link to Item History'),
sub_item_grp_sid BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Additional Link to UWG Default values in case of missing UWGs'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='UWG Src CD'),
item_grp_int_sid BIGNUMERIC(38,0) DEFAULT - 1 OPTIONS(description='Sid for item international group. (WGI)'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item sub group description (international).'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_name STRING(16777216) OPTIONS(description='(short) item name in local LANGUAGE'),
action_type_id INTEGER NOT NULL
OPTIONS(description='Action-Type_ID set to WaWi-Werbe-PV. Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS'),
theme_grp_nat_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='FK to Theme Group NAT'),
theme_grp_int_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='FK to Theme Group INTEGER '),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='FK to Theme Group NAT Category'),
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
OPTIONS(description='Basis Pre Fact Table on Store Day Item and WaWi-Werbe_PV Periods (Store and Country) Level (WaWi-Werbe-PV)');