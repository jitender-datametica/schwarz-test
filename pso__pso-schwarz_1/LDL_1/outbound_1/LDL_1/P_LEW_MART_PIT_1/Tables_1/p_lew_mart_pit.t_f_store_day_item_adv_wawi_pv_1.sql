/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for sales_1 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-04-01 Andreas Kurz	    Initial version
#  1.1  2024-10-31 Prasanna Ranjan  DDL consistency correction
#  1.2  2024-11-03 Nikolai Toknov	Rename the table T_F_STORE_DAY_ITEM_WAWI_PV -> T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 
#  1.3  2024-11-20 Nikolai Toknov   Rename PV_CALCULATED_VAL -> PV_CALCULATED_NET_VAL,
#  1.4  2025-01-15 Nikolai Toknov	Remove dublication (ITEM_UNIT_PRICE_PREV_DAY)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_1;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP SPECIAL_RECEIPT_TURNOVER_NET_VAL	NUMBER(38,5)																	
COMMENT '';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD TOTAL_PER_DAY_RCPT_CNT			NUMBER(38,0)																		COMMENT 'Total NBR_OF_BONS';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD TOTAL_PER_DAY_RCPT_CNT_LP			NUMBER(38,0)																		COMMENT 'Total NBR_OF_BONS LP';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD TOTAL_PER_DAY_RCPT_CNT_PD	        NUMBER(38,0)																		COMMENT 'Total NBR_OF_BONS PD_1';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD TOTAL_PER_DAY_RCPT_CNT_WAWI_PV    NUMBER(38,0)																		COMMENT 'Total NBR_OF_BONS WAWI PV';


ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD REPORTING_ADV_PERIOD_START_DAY_DT 	DATE 			NOT NULL	DEFAULT DATE '8888-12-31' 			COMMENT '';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD REPORTING_ADV_PERIOD_END_DAY_DT 	DATE 			NOT NULL	DEFAULT DATE '8888-12-31' 			COMMENT '';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD REPORTING_ADV_PERIOD_FG 			INTEGER 					DEFAULT 1                                  				COMMENT '';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD ACTION_SUBTYPE_ID					INTEGER 		DEFAULT -1 												COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | PD_1 ::= 3 | -1 ::= N/A | -2 ::= Total PV)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP PRICE_DROP_FIRST_DT;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP PV_CALCULATED_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP PRICE_DROP_LAST_DT;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP ITEM_SAME_PRICE;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP PCH_DISCOUNT_VALUE;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP RETAIL_PRICE_GROSS;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP PREV_DAY_DT

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD
	ITEM_SAME_PRICE_FG					INTEGER NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if Vk_1 (alt) = VK_1 (Neu)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD
	WAWI_RETAIL_PRICE_FG				INTEGER NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if WaWi Retail Price from PricePyramide is lower than the ITEM_UNIT_PRICE from EJR';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 DROP PREV_DAY_DT 
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD
	PREV_DAY_DT							DATE			NULL DEFAULT NULL
	 			COMMENT 'Date value of the prev day from which we got the ITEM_UNIT_PRICE_PREV_DAY';
UPDATE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1
SET PREV_DAY_DT = Iff(PREV_DAY_DT IS NULL, '8888-12-31'::DATE, PREV_DAY_DT)

DEFAULT DATE '8888-12-31'

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD
EFF_PRICE_GROSS						NUMBER(38,5)																		COMMENT 'Berechneter Verkaufspreis lt. EJR';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD
	SALES_PRICE_GROSS					NUMBER(38,5)																		COMMENT 'Berechneter Verkaufspreis lt. EJR';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_WAWI_PV_1 ADD
PV_CALCULATED_NET_VAL				NUMBER(38,5) 																		COMMENT 'Calculated PV Value if Action type = PV (Price Old – Price New)* sales_qty';

*/


-- FAKTEN / MEASURES / KPIs

-- ITEM_UNIT_PRICE_PREV_DAY			NUMBER(38,5)																		COMMENT 'Item_1 Unit_1 Price (previous day with sale)',

-- AKU 2022-01-27 Note only national currency's of the countries are used
 -- Technical fields

-- ORIG_ITEM_MSTR_NR					INTEGER						DEFAULT -1 												COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link - Frontend CROSS JOIN',

-- Stock from previous 5 days plus Delivery Qty from 5 days before and 13 days after

-- AKU 2022-01-19 Possible preaggregation of KPIs based on timeframes of KPI sheet

-- need to be reconsidered! only an example
 -- AKU 2022-01-24 Adding some baseline facts

-- Buying Preis Effective - Information from WH based on CNTL table of Buying price ranges
 -- Add 2022.05.19

-- Real Delivered Quantity
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_store_day_item_adv_wawi_pv_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_1 Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History'),
sub_item_grp_sid INTEGER DEFAULT - 1
OPTIONS(description='Additional Link to UWG Default values in case of missing UWGs'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='UWG Src CD'),
item_grp_int_sid INTEGER DEFAULT - 1 OPTIONS(description='Sid for item_1 international group. (WGI)'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item_1 sub group description (international).'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_name STRING(16777216) OPTIONS(description='(short) item_1 name in local LANGUAGE'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_1'),
week_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Week (based on ISO) of Sales. Added to have better CROSS JOIN options in aggregation process'),
month_id INTEGER DEFAULT 888812 NOT NULL OPTIONS(description='Month of Sales_1'),
year_id INTEGER DEFAULT 8888 NOT NULL OPTIONS(description='Year (based on ISO) of Sales_1'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER NOT NULL OPTIONS(description='Advertising Period WaWi-PV'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start day of Advertisement Period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End day of Advertisement Period'),
adv_length_of_period INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Length Advertisement Period in Days'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start day of Advertisement Period'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End day of Advertisement Period'),
reporting_adv_period_fg INTEGER DEFAULT 1
OPTIONS(description='Indicator [0,1] If day between periods start / end then 1'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
warehouse_sid INTEGER DEFAULT - 1 OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse NUMBER  / code from Wawi'),
curr_sid INTEGER DEFAULT - 1 OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country_1'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
theme_grp_nat_sid INTEGER OPTIONS(description='FK to Theme Group NAT'),
theme_grp_int_sid INTEGER OPTIONS(description='FK to Theme Group INTEGER '),
theme_grp_nat_cat_sid INTEGER OPTIONS(description='FK to Theme Group NAT Category'),
action_type_id INTEGER DEFAULT - 1
OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS'),
a_level_id INTEGER DEFAULT - 1 OPTIONS(description='Aggregation Level of the KPI'),
sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Quantity Abverkauf'),
return_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Quantity Returned Goods'),
discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discounted Quantity of Sales_1 Goods e.g. 1plus1'),
sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Amount Net in Local Currency'),
return_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Amount Returned items in Local Currency'),
discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Amount Discounted items in Local Currency'),
turnover_qty BIGNUMERIC(38,5) OPTIONS(description='Calcualted Quantity  Sales_1 + Returns (adjusted)'),
turnover_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Net Value Sales_1 + Returns (adjusted)'),
turnover_sales_gross_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Gross Value Sales_1 + Returns (adjusted)'),
vat_factor BIGNUMERIC(38,5) DEFAULT 0 OPTIONS(description='Tax Vat Factor e.g. 0,2 for 20%'),
total_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For All-Items on the Receipt Calcualted Net Sales_1 + Returns (adjusted)'),
promo_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For PROMO-Items (NF FA + PV) on the Receipt Calcualted Net Sales_1 + Returns (adjusted)'),
np_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Net Sales_1 + Returns (adjusted)'),
receipt_cnt BIGNUMERIC(38,0) OPTIONS(description='NBR_OF_BONS'),
total_per_day_rcpt_cnt BIGNUMERIC(38,0) OPTIONS(description='Total NBR_OF_BONS'),
price_old_gross BIGNUMERIC(38,5) OPTIONS(description='VK_1-Alt Preis (Brutto)'),
price_new_gross BIGNUMERIC(38,5) OPTIONS(description='VK_1-Neu Preis (Brutto), WaWi-PV'),
item_same_price_fg INTEGER DEFAULT - 1 OPTIONS(description='Flag /Indicator Old and New Price are the same'),
cheaper_in_pct BIGNUMERIC(38,5) OPTIONS(description='Billiger in  %'),
pv_calculated_net_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated PV ValuePV-Value if Action type = PV (Price Old – Price New)* sales_qty'),
item_unit_price BIGNUMERIC(38,5) OPTIONS(description='Item_1 Unit_1 Price needed for PV Calculation algortithm'),
item_unit_price_prev_day BIGNUMERIC(38,5) OPTIONS(description='Item_1 Unit_1 Price (previous day with sale)'),
sales_price_gross BIGNUMERIC(38,5) OPTIONS(description='Berechneter Verkaufspreis lt. EJR'),
eff_price_gross BIGNUMERIC(38,5) OPTIONS(description='Berechneter Verkaufspreis lt. EJR'),
wawi_price_retail_gross BIGNUMERIC(38,5) OPTIONS(description='WaWi-Verkaufspreis lt. PreisPyramide'),
prev_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Date value of the prev day from which we got the ITEM_UNIT_PRICE_PREV_DAY'),
wawi_retail_price_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if WaWi Retail Price from PricePyramide is lower than the ITEM_UNIT_PRICE from EJR'),
base_receipt_cnt BIGNUMERIC(38,5) OPTIONS(description='Bons Baseline (Anz.): Receipts count (last 6 weeks lfl)'),
base_restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Ø-Restbon Baseline: Sales_1 net val minus returns of Restbon (last 6 weeks lfl)'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Baseline: Sales_1 net val minus returns (last 6 weeks lfl)'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Abverkauf Baseline (Stk/kg): Sales_1 qty minus returns (last 6 weeks lfl)'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Abverkaufsertrag Baseline, calculated from sales_1 net val minus returns (last 6 weeks lfl)'),
delivered_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of items to be promoted ( stock on the day before the extended period starts and delivery to the store during the period). '),
item_buying_price_eff BIGNUMERIC(38,5)
OPTIONS(description='Einkaufspreis (EK) Buying Price calcualted based on the CNTL Table BuyingPrice Range;. Distributed equaly via the item_sid CROSS JOIN via orig_item_nr'),
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
OPTIONS(description='Basis Fact Table on Store Day Item_1 (WAWI PV)');