/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_STORE_DAY_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table Delivery to WH
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0		2021-07-01 Andreas Kurz		Initial version
#	1.2		2021-08-23 Mike Davis		Checks, formatting, FK support (now removed)
#	1.3		2022-01-24 Andreas Kurz		Reworked the structure after DM review
#									introduced DELIVERED_QTY
#	1.4		2022-03-31 Nikolai Toknov	Add ADV_PERIOD_ID to PRIMARY KEY for table F_STORE_DAY_ITEM
#	1.5		2022-04-21 Nikolai Toknov	Add columns: RECEIPT_CNT, RESTBON_TURNOVER_NET_VAL, RESTBON_NP_TURNOVER_NET_VAL
#	1.6		2022-04-26 Nikolai Toknov	Add columns: REPORT_ADV_PERIOD_START_DAY_DT,REPORT_ADV_PERIOD_END_DAY_DT
#	1.7		2022-04-27 Nikolai Toknov	Rename columns: REPORT_ADV_PERIOD_ -> REPORTING_ADV_PERIOD_
#	1.8		2022-04-27 Nikolai Toknov	Add REPORTING_ADV_PERIOD_FG
#	1.9		2022-05-19 Nikolai Toknov	Add TOTAL_SALES_NET_VAL, TOTAL_PROMO_SALES_NET_VAL. Drop ITEM_STOCK_REAL_QTY, ITEM_DELIVERY_TO_STORE_QTY
#	1.10  	2022-06-17 Nikolai Toknov	Change 
#											TOTAL_SALES_NET_VAL  		-> TOTAL_RECEIPT_TURNOVER_NET_VAL
#											TOTAL_PROMO_SALES_NET_VAL  	-> PROMO_RECEIPT_TURNOVER_NET_VAL
#										Add:
#											NP_RECEIPT_TURNOVER_NET_VAL
#										Drop:
#											RESTBON_TURNOVER_NET_VAL
#											RESTBON_NP_TURNOVER_NET_VAL	
#  1.11		2022-07-06 Nikolai Toknov	Change column ADV_THEME_NATIONAL_SID,ADV_THEME_INTERNATIONAL_SID -> THEME_GID,THEME_GRP_SID 
#  1.12		2023-03-16 Nikolai Toknov	INTEGER /NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INTEGER  - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  1.13  	2023-09-05 Andreas Kurz		Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
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
*/


-- Stock from previous 5 days plus Delivery Qty from 5 days before and 13 days after
 -- ),

-- REPORTING_ADV_PERIOD_FG				INTEGER AS (

-- THEME_INT_SID						INTEGER																				COMMENT 'Unique system ID, sid, for the theme INTEGER .',

-- THEME_GRP_INT_MSTR_SID				INTEGER																				COMMENT '[VC] MSTR surrogate Key : Theme Group INTEGER ',

-- IFF((DAY_DT >= REPORTING_ADV_PERIOD_START_DAY_DT) AND (DAY_DT <= REPORTING_ADV_PERIOD_END_DAY_DT), 1, 0)

-- THEME_GRP_NAT_MSTR_SID				INTEGER																				COMMENT '[VC] MSTR surrogate Key : Theme Group NAT',

-- AKU 2022-01-27 Note only national currency's of the countries are used

-- THEME_GRP_NAT_CAT_MSTR_SID			INTEGER		 																		COMMENT 'MSTR surrogate Key : Theme Group NAT Category',

-- Add 2022.04.21

-- THEME_NAT_SID						INTEGER																				COMMENT 'Unique system ID, sid, for the theme NAT.',

-- Buying Preis Effective - Information from WH based on CNTL table of Buying price ranges

-- ADV_PERIOD_MSTR_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Advertising Period - Frontend CROSS JOIN',

-- FAKTEN / MEASURES / KPIs
 -- THEME_INT_MSTR_SID					INTEGER																				COMMENT '[VC] MSTR surrogate Key',

-- ADV_WEEK_MSTR_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Advertising Week - Frontend CROSS JOIN',

-- AKU 2022-01-24 for future use

-- THEME_NAT_MSTR_SID					INTEGER																				COMMENT '[VC] MSTR surrogate Key',

-- AKU 2022-01-24 for future use SFO (PV)
 -- Technical fields
 -- AKU 2022-01-24 for future use SFO (PV)

-- ORIG_ITEM_MSTR_NR					INTEGER						DEFAULT -1 												COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link - Frontend CROSS JOIN',

-- AKU 2022-01-19 Possible preaggregation of KPIs based on timeframes of KPI sheet
 -- Add 2022.05.19

-- AKU 2022-01-24 Adding some baseline facts
 -- need to be reconsidered! only an example
 -- Real Delivered Quantity

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_store_day_item_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_1 Variant (Case Size)'),
orig_item_nr INTEGER OPTIONS(description='Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History'),
sub_item_grp_sid INTEGER DEFAULT - 1
OPTIONS(description='Additional Link to UWG Default values in case of missing UWGs'),
item_grp_int_sid INTEGER DEFAULT - 1 OPTIONS(description='Additional Link to WGI Default values in case of missing WGI'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_1'),
week_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Week (based on ISO) of Sales. Added to have better CROSS JOIN options in aggregation process'),
month_id INTEGER DEFAULT 888812 NOT NULL OPTIONS(description='Month of Sales_1'),
year_id INTEGER DEFAULT 8888 NOT NULL OPTIONS(description='Year (based on ISO) of Sales_1'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER NOT NULL OPTIONS(description='Advertising Period'),
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
curr_sid INTEGER DEFAULT - 1 OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country_1'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
theme_grp_nat_sid INTEGER OPTIONS(description='FK to Theme Group NAT'),
theme_grp_int_sid INTEGER OPTIONS(description='FK to Theme Group INTEGER '),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 OPTIONS(description='FK to Theme Group NAT Category'),
action_type_id INTEGER DEFAULT - 1 OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV'),
item_fa_fg INTEGER DEFAULT 0,
item_nf_fg INTEGER DEFAULT 0,
item_pv_fg INTEGER DEFAULT 0,
item_np_fg INTEGER DEFAULT 0,
a_level_id INTEGER DEFAULT - 1 OPTIONS(description='Aggregation Level of the KPI'),
sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Quantity Abverkauf'),
return_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Quantity Returned Goods'),
discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discounted Quantity of Sales_1 Goods e.g. 1plus1'),
sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Amount Net in Local Currency'),
return_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Amount Returned items in Local Currency'),
discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 Amount Discounted items in Local Currency'),
turnover_qty BIGNUMERIC(38,5) OPTIONS(description='Calcualted Quantity  Sales_1 + Returns (adjusted)'),
turnover_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Net Value Sales_1 + Returns (adjusted)'),
vat_factor BIGNUMERIC(38,5) DEFAULT 0 OPTIONS(description='Tax Vat Factor e.g. 0,2 for 20%'),
eff_price_gross BIGNUMERIC(38,5) OPTIONS(description='Item_1 Variant Sales_1 Price Gross New == reduced price'),
eff_price_net BIGNUMERIC(38,5) OPTIONS(description='Item_1 Variant Sales_1 Price Net New == reduced price'),
sales_price_gross BIGNUMERIC(38,5) OPTIONS(description='Item_1 Variant Sales_1 Price Gross New == reduced price'),
sales_price_net BIGNUMERIC(38,5) OPTIONS(description='Item_1 Variant Sales_1 Price Net New == reduced price'),
total_receipt_turnover_net_val BIGNUMERIC(38,5),
promo_receipt_turnover_net_val BIGNUMERIC(38,5),
np_receipt_turnover_net_val BIGNUMERIC(38,5),
receipt_cnt BIGNUMERIC(38,0),
sales_default_price_gross BIGNUMERIC(38,5)
OPTIONS(description='Future Use: Item_1 Variant Sales_1 Price Gross Default price relevant for PV'),
sales_default_price_net BIGNUMERIC(38,5)
OPTIONS(description='Future Use : Item_1 Variant Sales_1 Price Net Default price relevant for PV'),
item_same_price_fg INTEGER DEFAULT - 1 OPTIONS(description='Flag /Indicator Old and New Price are the same'),
price_drop_first_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Future Use: PV Optional: First Day of Price  Drop Detected'),
price_drop_last_dt DATE DEFAULT DATE '8888-12-31'
OPTIONS(description='Future Use: PV Optional: Last Day of Price  Drop Detected'),
cheaper_in_pct BIGNUMERIC(38,5) OPTIONS(description='Billiger in  %'),
pv_calculated_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated PV ValuePV-Value if Action type = PV (Price Old – Price New)* sales_qty'),
pv_sfo_val BIGNUMERIC(38,5) OPTIONS(description='PV-Value from SFO '),
base_receipt_cnt BIGNUMERIC(38,5) OPTIONS(description='Bons Baseline (Anz.): Receipts count (last 6 weeks lfl)'),
base_restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Ø-Restbon Baseline: Sales_1 net val minus returns of Restbon (last 6 weeks lfl)'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Baseline: Sales_1 net val minus returns (last 6 weeks lfl)'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Abverkauf Baseline (Stk/kg): Sales_1 qty minus returns (last 6 weeks lfl)'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Abverkaufsertrag Baseline, calculated from sales_1 net val minus returns (last 6 weeks lfl)'),
delivered_qty BIGNUMERIC(38,5),
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
OPTIONS(description='Basis Fact Table on Store Day Item_1');