/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_ADV_LP_PV_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2024-06-24 Andreas Kurz 	Initial version
# 1.1 2024-08-05 Andreas Kurz 	Added PV_SUBTYPE_ID
#								Removed ITEM_PV_PD_FG
# 1.2 2024-08-06 Andreas Kurz	Changed name PV_SUBTYPE_ID --> ACTION_SUBTYPE_ID
# 1.3 2024-10-29 Andreas Kurz	Added the STRUCTURE
#								Removed ACTION_SUBTYPE_ID
#								Added REPORTING_LP_PROMO_START_DT and REPORTING_LP_PROMO_END_DT
# 1.4 2024-11-07 Nikolai Toknov	Drop column ADV_PERIOD_ID
# 1.5 2024-11-13 Nikolai Toknov Drop column RECEIPTLINE_NR, add COUPON_PROMO_SID_LIST
# 1.6 2025-05-14 Nikolai Toknov Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)																							 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_1;

ALTER TABLE LDL.P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV DROP ITEM_PV_PD_FG;
ALTER TABLE LDL.P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV ADD 	PV_SUBTYPE_ID					INTEGER			NOT NULL	DEFAULT 20									COMMENT 'PV Subtype ID - LP'

ALTER TABLE LDL.P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV DROP PV_SUBTYPE_ID;
ALTER TABLE LDL.P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV ADD 	ACTION_SUBTYPE_ID				INTEGER			NOT NULL	DEFAULT 20									COMMENT 'PV Subtype ID - LP'

ALTER TABLE LDL.P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV	ADD REPORTING_LP_PROMO_START_DT		DATE																	COMMENT 'Reporting LP Period Start Day. Special Case of Germany and LP Periods Starting on Sunday'

ALTER TABLE LDL.P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV	ADD REPORTING_LP_PROMO_END_DT		DATE																	COMMENT 'ReportingLP Period End Day = LP Period End Day. Just for naming consency applied'


ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 RENAME COLUMN DISCOUNT_PCT to COUPON_DISCOUNT_PCT;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 DROP COLUMN DISCOUNT_PCT_FACTOR, SALES_PRICE_GROSS;

 ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 ADD 
COUPON_TYPE_CD	 				STRING(40) 															COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
	COUPON_ORIG_COUPON_TYPE_DESCR	STRING																	COMMENT 'unique code identifying the type of the coupon from LDL.ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.';
	COUPON_REDUCED_SALES_PRICE 		NUMBER(38,5) 															COMMENT 'the special price of the product that is linked to the coupon',
	COUPON_DISCOUNT_VAL 			NUMBER(38,5) 															COMMENT 'by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers',
	--COUPON_DISCOUNT_PCT 			NUMBER(38,5) 															COMMENT 'by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers',
	COUPON_DISCOUNT_X_CNT 			NUMBER(38,0) 															COMMENT 'how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt',
	COUPON_DISCOUNT_Y_CNT 			NUMBER(38,0) 															COMMENT 'how many pieces the customer gets in case he buys x_cnt'																							 
*/


-- DISCOUNT_PCT_FACTOR				NUMBER(38,5)															COMMENT 'Discount in % Factor',

-- ADV_PERIOD_ID					INTEGER			NOT NULL												COMMENT 'Adv.Period of the Receipt',

-- RECEIPTLINE_NR					INTEGER																	COMMENT 'Consecutive number on receipt',
 -- debag
 -- Technical fields

-- SALES_PRICE_GROSS				NUMBER(38,5)															COMMENT 'Item_1 Variant Sales_1 Price Gross New == reduced price',

-- DISCOUNT_PCT					NUMBER(38,5)															COMMENT 'Discount in %',
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_p_f_adv_lp_pv_1
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_1'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Adv.Week of the Receipt DATE'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_1 Variant (Case Size)'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
receipt_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View'),
coupon_promo_sid INTEGER OPTIONS(description='Unique identifier of the coupon_promotion (surrogate key)'),
src_coupon_promo_nr STRING(16777216) OPTIONS(description='identifier of the coupon_promotion within LidlPlus/SCRM '),
discount_sid INTEGER NOT NULL OPTIONS(description='Technical ID for historicized discount'),
discount_descr STRING(16777216) OPTIONS(description='Description of the discount'),
discount_type STRING(16777216) OPTIONS(description='Type of discount'),
src_discount_nr STRING(16777216) OPTIONS(description='Estate number on EJR (Business Key)'),
lidlplus_coupon_pattern_fg INTEGER OPTIONS(description='Flag for LIDL PLUS Coupon'),
discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discounted Quantity of Sales_1 Goods e.g. 1plus1'),
discount_val BIGNUMERIC(38,5) OPTIONS(description='Absolute value of discount'),
transaction_type_cd INTEGER OPTIONS(description='Array of UPI Columns of the associated table'),
pit_adv_item_cnt_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_discount_val_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_discount_qty_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_discount_sales_qty_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_pos_gkdos_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_price_retail_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_receipt_cnt_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_distinct_receipt_cnt_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_return_val_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_return_qty_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_return_receipt_cnt_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_sales_val_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_sales_qty_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_store_cnt_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_turnover_val_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_turnover_qty_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_void_val_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_void_qty_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_write_off_fg INTEGER
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
coupon_type_cd STRING(40)
OPTIONS(description='unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.'),
coupon_name STRING(16777216)
OPTIONS(description='The name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)'),
orig_coupon_type_sid INTEGER
OPTIONS(description='Unique identifier of the category in SCRM table promotionhst (surrogate key)'),
coupon_orig_coupon_type_descr STRING(16777216)
OPTIONS(description='unique code identifying the type of the coupon from LDL.ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.'),
coupon_reduced_sales_price BIGNUMERIC(38,5)
OPTIONS(description='the special price of the product that is linked to the coupon'),
coupon_discount_val BIGNUMERIC(38,5)
OPTIONS(description='by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers'),
coupon_discount_pct BIGNUMERIC(38,5)
OPTIONS(description='by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers'),
coupon_discount_x_cnt BIGNUMERIC(38,0)
OPTIONS(description='how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt'),
coupon_discount_y_cnt BIGNUMERIC(38,0) OPTIONS(description='how many pieces the customer gets in case he buys x_cnt'),
coupon_promo_type_sid INTEGER
OPTIONS(description='Unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)'),
coupon_promo_benefit_txt STRING(16777216)
OPTIONS(description='Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field TillCoupons.SalesforceCouponType)'),
lp_pv_promo_start_dt DATE OPTIONS(description='LP Period Start Day'),
lp_pv_promo_end_dt DATE OPTIONS(description='LP Period End Day'),
reporting_lp_promo_start_dt DATE
OPTIONS(description='Reporting LP Period Start Day. Special Case of Germany and LP Periods Starting on Sunday'),
reporting_lp_promo_end_dt DATE
OPTIONS(description='ReportingLP Period End Day = LP Period End Day. Just for naming consency applied'),
scratch_redemtion_day_qty INTEGER
OPTIONS(description='Number of days the coupon_promotion validity_1 period is longer than the validity_1 of the gamification element of the coupon_promotion.'),
length_of_period INTEGER OPTIONS(description='Length Advertisement Period in Days'),
coupon_promo_sid_list STRING(16777216) OPTIONS(description='Unique identifier of the coupon_promotion (surrogate key)'),
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
PRIMARY KEY (client_id, day_dt, store_sid, item_sid, receipt_sid, discount_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Preliminary Fact Table on receipt line LidlPlus Promotions');