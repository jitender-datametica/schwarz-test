/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_STORE_DAY_ITEM_ADV_LP_PV_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for sales_2 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-11-03 Nikolai Toknov	Initial version
#  1.1	2024-11-14 Nikolai Toknov	Drop column REPORTING_ADV_PERIOD_FG
#  1.2  2024-11-17 Nikolai Toknov	Add 	SALES_PRICE_GROSS
#  1.3  2024-11-18 Nikolai Toknov 	Drop columns PRICE_DROP_FIRST_DT, PRICE_DROP_LAST_DT, PCH_DISCOUNT_VALUE,  RETAIL_PRICE_GROSS
#  1.4  2024-11-20 Nikolai Toknov	Drop ITEM_UNIT_PRICE_PREV_DAY, TOTAL_PER_DAY_RCPT_CNT. Rename PV_CALCULATED_VAL -> PV_CALCULATED_NET_VAL, add 	PV_CALCULATED_LP_ONLY_NET_VAL, PV_CALCULATED_WAWI_UNDER_LP_NET_VAL
#  1.5  2024-12-09 Nikolai Toknov	Add NP and PV columns
#  1.6  2024-12-22 Nikolai Toknov	Rename ADV_LENGTH_OF_PERIOD -> ADV_PERIOD_LENGTH_IN_DAYS
#-------------------------------------------------------------------------------
*/                                               
                                                 
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;
*/


-- AKU 2022-01-27 Note only national currency's of the countries are used
 -- Technical fields
 -- debug

-- REPORTING_ADV_PERIOD_FG 			INTEGER 					DEFAULT 1                                  				COMMENT 'Indicator [0,1] If day between periods start / end then 1',

-- Stock from previous 5 days plus Delivery Qty from 5 days before and 13 days after
 -- Real Delivered Quantity

-- Buying Preis Effective - Information from WH based on CNTL table of Buying price ranges
 -- FAKTEN / MEASURES / KPIs

-- need to be reconsidered! only an example
 -- AKU 2022-01-24 Adding some baseline facts

-- AKU 2022-01-19 Possible preaggregation of KPIs based on timeframes of KPI sheet

-- ORIG_ITEM_MSTR_NR					INTEGER						DEFAULT -1 												COMMENT 'Item_2 NaN (National Artikel_2 Nummer) Link - Frontend CROSS JOIN',

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_store_day_item_adv_lp_pv_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_2 Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item_2 NaN (National Artikel_2 Nummer) Link to Item_2 History'),
sub_item_grp_sid INTEGER DEFAULT - 1
OPTIONS(description='Additional Link to UWG Default values in case of missing UWGs'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='UWG Src CD'),
item_grp_int_sid INTEGER DEFAULT - 1 OPTIONS(description='Sid for item_2 international group. (WGI)'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item_2 sub group description (international).'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Code for international group from source system.'),
item_grp_int_descr STRING(16777216) OPTIONS(description='International group description (local).'),
item_name STRING(16777216) OPTIONS(description='(short) item_2 name in local LANGUAGE'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_2'),
week_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Week (based on ISO) of Sales. Added to have better CROSS JOIN options in aggregation process'),
month_id INTEGER DEFAULT 888812 NOT NULL OPTIONS(description='Month of Sales_2'),
year_id INTEGER DEFAULT 8888 NOT NULL OPTIONS(description='Year (based on ISO) of Sales_2'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER NOT NULL OPTIONS(description='Advertising Period WaWi-PV'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start day of Advertisement Period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End day of Advertisement Period'),
adv_period_length_in_days INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Length Advertisement Period in Days'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start day of Advertisement Period'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End day of Advertisement Period'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_2 surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
warehouse_sid INTEGER DEFAULT - 1 OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse NUMBER  / code from Wawi'),
curr_sid INTEGER DEFAULT - 1 OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country_2'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
theme_grp_nat_sid INTEGER OPTIONS(description='FK to Theme Group NAT'),
theme_grp_int_sid INTEGER OPTIONS(description='FK to Theme Group INTEGER '),
theme_grp_nat_cat_sid INTEGER OPTIONS(description='FK to Theme Group NAT Category'),
action_type_id INTEGER DEFAULT - 1
OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS'),
a_level_id INTEGER DEFAULT - 1 OPTIONS(description='Aggregation Level of the KPI'),
sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Quantity Abverkauf'),
return_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Quantity Returned Goods'),
discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discounted Quantity of Sales_2 Goods e.g. 1plus1'),
sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Net in Local Currency'),
return_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Returned items in Local Currency'),
discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Discounted items in Local Currency'),
turnover_qty BIGNUMERIC(38,5) OPTIONS(description='Calcualted Quantity  Sales_2 + Returns (adjusted)'),
turnover_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Net Value Sales_2 + Returns (adjusted)'),
turnover_sales_gross_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Gross Value Sales_2 + Returns (adjusted)'),
vat_factor BIGNUMERIC(38,5) DEFAULT 0 OPTIONS(description='Tax Vat Factor e.g. 0,2 for 20%'),
total_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For All-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
promo_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For PROMO-Items (NF FA + PV) on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
np_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
receipt_cnt BIGNUMERIC(38,0) OPTIONS(description='NBR_OF_BONS'),
price_old_gross BIGNUMERIC(38,5) OPTIONS(description='VK_2-Alt Preis (Brutto)'),
price_new_gross BIGNUMERIC(38,5) OPTIONS(description='VK_2-Neu Preis (Brutto), WaWi-PV'),
item_same_price INTEGER DEFAULT - 1 OPTIONS(description='Flag /Indicator Old and New Price are the same'),
sales_price_gross BIGNUMERIC(38,5) OPTIONS(description='Item_2 Variant Sales_2 Price Gross New == reduced price'),
cheaper_in_pct BIGNUMERIC(38,5) OPTIONS(description='Billiger in  %'),
pv_calculated_net_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated PV ValuePV-Value if Action type = PV (Price Old – Price New)* sales_qty'),
item_unit_price BIGNUMERIC(38,5) OPTIONS(description='Item_2 Unit_2 Price needed for PV Calculation algortithm'),
base_receipt_cnt BIGNUMERIC(38,5) OPTIONS(description='Bons Baseline (Anz.): Receipts count (last 6 weeks lfl)'),
base_restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Ø-Restbon Baseline: Sales_2 net val minus returns of Restbon (last 6 weeks lfl)'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Baseline: Sales_2 net val minus returns (last 6 weeks lfl)'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Abverkauf Baseline (Stk/kg): Sales_2 qty minus returns (last 6 weeks lfl)'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Abverkaufsertrag Baseline, calculated from sales_2 net val minus returns (last 6 weeks lfl)'),
delivered_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of items to be promoted ( stock on the day before the extended period starts and delivery to the store during the period).'),
item_buying_price_eff BIGNUMERIC(38,5)
OPTIONS(description='Einkaufspreis (EK) Buying Price calcualted based on the CNTL Table BuyingPrice Range;. Distributed equaly via the item_sid CROSS JOIN via orig_item_nr'),
pv_calculated_lp_only_net_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated PV for LP only (w/o impact from WAWI-PV)'),
pv_calculated_wawi_under_lp_net_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated WAWI-PV under LP (In case the periods overlap)'),
np_item_unit_price_gross BIGNUMERIC(38,5),
np_item_unit_price_net BIGNUMERIC(38,5),
np_pricegroup_desc STRING(16777216),
np_pricegroup_id INTEGER,
np_pricegroup_priority INTEGER,
pv_item_unit_price_gross BIGNUMERIC(38,5),
pv_item_unit_price_net BIGNUMERIC(38,5),
pv_pricegroup_desc STRING(16777216),
pv_pricegroup_id INTEGER,
pv_pricegroup_priority INTEGER,
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
OPTIONS(description='Basis Fact Table on Store Day Item_2 (LP PV)');