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
#	1.0		2023-07-25 Nikolai Toknov		Initial version
#	1.1		2023-08-21 Nikolai Toknov		Change comments
#-------------------------------------------------------------------------------
*/


-- AKU 2022-01-27 Note only national currency's of the countries are used
 -- FAKTEN / MEASURES / KPIs

-- Technical fields
 -- DELIVERED_QTY						NUMBER(38,5),
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_psnf_store_day_item_2
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_2 Variant (Case Size)'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Item_2 NaN (National Artikel_2 Nummer) Link to Item_2 History'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_2'),
adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start day of the extended period'),
adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End day of the extended period'),
reporting_adv_period_start_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start day of Advertisement Period'),
reporting_adv_period_end_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End day of Advertisement Period'),
overlap_period_fg INTEGER DEFAULT 0 OPTIONS(description='If periods overlap'),
cut_period_fg INTEGER DEFAULT 0
OPTIONS(description='If periods overlap and  start date difference is greater than 7 days and which have an overlap'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_2 surrogate key'),
store_name STRING(16777216) OPTIONS(description='Store Name'),
orig_store_nr INTEGER OPTIONS(description='Orig Store NUMBER'),
curr_sid INTEGER DEFAULT - 1 OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country_2'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Quantity Abverkauf'),
return_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Quantity Returned Goods'),
discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discounted Quantity of Sales_2 Goods e.g. 1plus1'),
sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Net in Local Currency'),
sales_gross_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Gross in Local Currency'),
return_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Returned items Net in Local Currency'),
return_gross_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Returned items Gross in Local Currency'),
discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Discounted items Net in Local Currency'),
discount_gross_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Discounted items Gross in Local Currency'),
turnover_qty BIGNUMERIC(38,5) OPTIONS(description='Calcualted Quantity  Sales_2 + Returns (adjusted)'),
turnover_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Net Value Sales_2 + Returns (adjusted)'),
turnover_sales_gross_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Gross Value Sales_2 + Returns (adjusted)'),
vat_factor BIGNUMERIC(38,5) DEFAULT 0 OPTIONS(description='Tax Vat Factor e.g. 0,2 for 20%'),
eff_price_gross BIGNUMERIC(38,5) OPTIONS(description='Item_2 Variant Sales_2 Price Gross New == reduced price'),
eff_price_net BIGNUMERIC(38,5) OPTIONS(description='Item_2 Variant Sales_2 Price Net New == reduced price'),
sales_price_gross BIGNUMERIC(38,5) OPTIONS(description='Item_2 Variant Sales_2 Price Gross New == reduced price'),
sales_price_net BIGNUMERIC(38,5) OPTIONS(description='Item_2 Variant Sales_2 Price Net New == reduced price'),
receipt_cnt BIGNUMERIC(38,0),
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
PRIMARY KEY (client_id, day_dt, store_sid, orig_item_nr, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Basis Fact Table on Store Day Item_2');