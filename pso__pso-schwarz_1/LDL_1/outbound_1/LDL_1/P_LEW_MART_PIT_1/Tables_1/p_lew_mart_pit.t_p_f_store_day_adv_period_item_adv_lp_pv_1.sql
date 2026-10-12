/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for periods
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-11-05 Nikolai Toknov		Initial version
#  1.1  2024-11-07 Nikolai Toknov		Drop cilumns REPORTING_ADV_PERIOD_FG, DISCOUNT_VALUE
#  1.2  2024-11-14 Nikolai Toknov		Add SUB_ITEM_GRP_SID,SUB_ITEM_GRP_SRC_CD,ITEM_GRP_INT_SID,SUB_ITEM_GRP_INT_DESCR,ITEM_GRP_INT_SRC_CD,ITEM_GRP_INT_DESCR,ITEM_NAME,COUNTRY_ISO_CD,COUNTRY_DESCR
#  1.3  2024-11-14 Nikolai Toknov		Rename column ADV_PERIOD_END/START_DT to ADV_PERIOD_END/START_DAY_DT
#  1.4  2024-12-22 Nikolai Toknov		Rename ADV_LENGTH_OF_PERIOD -> ADV_PERIOD_LENGTH_IN_DAYS
#-------------------------------------------------------------------------------
*/

/*
DROP TABLE LDL.P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV_1
ALTER TABLE T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV_1 ADD 
	ADV_WEEK_ID 							INTEGER 													COMMENT '',
	ADV_PERIOD_ID 						INTEGER 		 												COMMENT '';
UPDATE 	T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV_1
set ADV_WEEK_ID=ADV_WEEK_PV_ID,
	ADV_PERIOD_ID=ADV_PERIOD_PV_ID;

	
*/


-- PCH_LENGTH_OF_PERIOD 					INTEGER 																COMMENT 'Length PriceChange Period in Days',

-- PCH_DAY_PRICEGROUP_FG					INTEGER COMMENT 'PV Tag_1 Preisschienen',

-- PCH_PERIOD_START_DT 					DATE 						DEFAULT DATE '8888-12-31' COMMENT 'Start day of PriceChange Period',

-- PCH_BASELINE_FG 						INTEGER COMMENT 'Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)',

-- Technical fields

-- REPORTING_ADV_PERIOD_FG 				INTEGER 					DEFAULT 1                                  	COMMENT 'Indicator [0,1] If day between periods start / end then 1',

-- PCH_PERIOD_END_DT 						DATE 						DEFAULT DATE '8888-12-31' COMMENT 'End day of PriceChange Period',
 CREATE TABLE
IF NOT EXISTS ldl_p_lew_mart_pit.t_p_f_store_day_adv_period_item_adv_lp_pv_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_1'),
store_sid INTEGER NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
warehouse_sid INTEGER OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER NOT NULL OPTIONS(description='Advertising Period'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='Start DATE of the Adv.Period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' OPTIONS(description='End DATE of the Adv.Period'),
adv_period_length_in_days INTEGER OPTIONS(description='Length Advertisement Period in Days'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start day of Advertisement Period'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End day of Advertisement Period'),
item_sid INTEGER NOT NULL OPTIONS(description='Item_1 Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History'),
sub_item_grp_sid INTEGER DEFAULT - 1
OPTIONS(description='Additional Link to UWG Default values in case of missing UWGs'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='UWG Src CD'),
item_grp_int_sid INTEGER DEFAULT - 1 OPTIONS(description='Sid for item_1 international group. (WGI)'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item_1 sub group description (international).'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_name STRING(16777216) OPTIONS(description='(short) item_1 name in local LANGUAGE'),
discount_value BIGNUMERIC(38,5) OPTIONS(description='Absolute value of discount'),
action_type_id INTEGER NOT NULL
OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS'),
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
PRIMARY KEY (client_id, day_dt, store_sid, item_sid, adv_week_id, adv_period_id, action_type_id) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Basis Pre Fact Table on Store Day Item_1 PV (WAWI_PV, LP and NPPS)');