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

ALTER TABLE P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV DROP ITEM_PV_PD_FG;
ALTER TABLE P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV ADD 	PV_SUBTYPE_ID					INTEGER			NOT NULL	DEFAULT 20									COMMENT 'PV Subtype ID - LP'
;
ALTER TABLE P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV DROP PV_SUBTYPE_ID;
ALTER TABLE P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV ADD 	ACTION_SUBTYPE_ID				INTEGER			NOT NULL	DEFAULT 20									COMMENT 'PV Subtype ID - LP'
;
ALTER TABLE P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV	ADD REPORTING_LP_PROMO_START_DT		DATE																	COMMENT 'Reporting LP Period Start Day. Special Case of Germany and LP Periods Starting on Sunday'
;
ALTER TABLE P_LEW_MART_PIT.T_T_P_F_ADV_LP_PV	ADD REPORTING_LP_PROMO_END_DT		DATE																	COMMENT 'ReportingLP Period End Day = LP Period End Day. Just for naming consency applied'
;

ALTER TABLE P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 RENAME COLUMN DISCOUNT_PCT to COUPON_DISCOUNT_PCT;
ALTER TABLE P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 DROP COLUMN DISCOUNT_PCT_FACTOR, SALES_PRICE_GROSS;

 ALTER TABLE P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 ADD 
COUPON_TYPE_CD	 				VARCHAR(40) 															COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
	COUPON_ORIG_COUPON_TYPE_DESCR	VARCHAR																	COMMENT 'unique code identifying the type of the coupon from ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.';
	COUPON_REDUCED_SALES_PRICE 		NUMBER(38,5) 															COMMENT 'the special price of the product that is linked to the coupon',
	COUPON_DISCOUNT_VAL 			NUMBER(38,5) 															COMMENT 'by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers',
	--COUPON_DISCOUNT_PCT 			NUMBER(38,5) 															COMMENT 'by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers',
	COUPON_DISCOUNT_X_CNT 			NUMBER(38,0) 															COMMENT 'how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt',
	COUPON_DISCOUNT_Y_CNT 			NUMBER(38,0) 															COMMENT 'how many pieces the customer gets in case he buys x_cnt'																							 
*/

CREATE TABLE P_LEW_MART_PIT.T_P_F_ADV_LP_PV_1 CLUSTER BY (CLIENT_ID, DAY_DT )(
	CLIENT_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g AT=1',
	DAY_DT							DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'Day of Sales_1',

	ADV_WEEK_ID						INTEGER			NOT NULL												COMMENT 'Adv.Week of the Receipt DATE',
--	ADV_PERIOD_ID					INTEGER			NOT NULL												COMMENT 'Adv.Period of the Receipt',

	ITEM_SID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Item_1 Variant (Case Size)',
	STORE_SID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique key Region_1 surrogate key',
	RECEIPT_SID						INTEGER			NOT NULL 												COMMENT 'Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	
--	RECEIPTLINE_NR					INTEGER																	COMMENT 'Consecutive number on receipt',
	COUPON_PROMO_SID				INTEGER																	COMMENT 'Unique identifier of the coupon_promotion (surrogate key)',
	SRC_COUPON_PROMO_NR				VARCHAR																	COMMENT 'identifier of the coupon_promotion within LidlPlus/SCRM ',
	DISCOUNT_SID					INTEGER																	COMMENT 'Technical ID for historicized discount',
	DISCOUNT_DESCR					VARCHAR																	COMMENT 'Description of the discount',
	DISCOUNT_TYPE					VARCHAR																	COMMENT 'Type of discount',
	SRC_DISCOUNT_NR					VARCHAR																	COMMENT 'Estate number on EJR (Business Key)',
	
	LIDLPLUS_COUPON_PATTERN_FG		SMALLINT																COMMENT 'Flag for LIDL PLUS Coupon',
					
	DISCOUNT_QTY					NUMBER(38,5)															COMMENT 'Discounted Quantity of Sales_1 Goods e.g. 1plus1',
	DISCOUNT_VAL					NUMBER(38,5)															COMMENT 'Absolute value of discount',
	TRANSACTION_TYPE_CD				INTEGER																	COMMENT 'Array of UPI Columns of the associated table',
	PIT_ADV_ITEM_CNT_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_VAL_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_QTY_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_SALES_QTY_FG		INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_POS_GKDOS_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_PRICE_RETAIL_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RECEIPT_CNT_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISTINCT_RECEIPT_CNT_FG		INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_VAL_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_QTY_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_RECEIPT_CNT_FG		INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_SALES_VAL_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_SALES_QTY_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_STORE_CNT_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_TURNOVER_VAL_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_TURNOVER_QTY_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_VOID_VAL_FG					INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_VOID_QTY_FG					INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_WRITE_OFF_FG				INTEGER																	COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',


	COUPON_TYPE_CD	 				VARCHAR(40) 															COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
	COUPON_NAME						VARCHAR																	COMMENT 'The name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)',
	ORIG_COUPON_TYPE_SID			INTEGER																	COMMENT 'Unique identifier of the category in SCRM table promotionhst (surrogate key)',
	COUPON_ORIG_COUPON_TYPE_DESCR	VARCHAR																	COMMENT 'unique code identifying the type of the coupon from ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',


	COUPON_REDUCED_SALES_PRICE 		NUMBER(38,5) 															COMMENT 'the special price of the product that is linked to the coupon',
	COUPON_DISCOUNT_VAL 			NUMBER(38,5) 															COMMENT 'by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers',
	COUPON_DISCOUNT_PCT 			NUMBER(38,5) 															COMMENT 'by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers',
	COUPON_DISCOUNT_X_CNT 			NUMBER(38,0) 															COMMENT 'how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt',
	COUPON_DISCOUNT_Y_CNT 			NUMBER(38,0) 															COMMENT 'how many pieces the customer gets in case he buys x_cnt',

	COUPON_PROMO_TYPE_SID			INTEGER																	COMMENT 'Unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)',
	COUPON_PROMO_BENEFIT_TXT		VARCHAR																	COMMENT 'Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field TillCoupons.SalesforceCouponType)',
	LP_PV_PROMO_START_DT			DATE																	COMMENT 'LP Period Start Day',
	LP_PV_PROMO_END_DT				DATE																	COMMENT 'LP Period End Day',
	REPORTING_LP_PROMO_START_DT		DATE																	COMMENT 'Reporting LP Period Start Day. Special Case of Germany and LP Periods Starting on Sunday',
	REPORTING_LP_PROMO_END_DT		DATE																	COMMENT 'ReportingLP Period End Day = LP Period End Day. Just for naming consency applied',

	SCRATCH_REDEMTION_DAY_QTY		INTEGER																	COMMENT 'Number of days the coupon_promotion validity_1 period is longer than the validity_1 of the gamification element of the coupon_promotion.',
	--SALES_PRICE_GROSS				NUMBER(38,5)															COMMENT 'Item_1 Variant Sales_1 Price Gross New == reduced price',
	--DISCOUNT_PCT					NUMBER(38,5)															COMMENT 'Discount in %',
	--DISCOUNT_PCT_FACTOR				NUMBER(38,5)															COMMENT 'Discount in % Factor',
	LENGTH_OF_PERIOD				INTEGER																	COMMENT 'Length Advertisement Period in Days',
	-- debag
	COUPON_PROMO_SID_LIST			VARCHAR																	COMMENT 'Unique identifier of the coupon_promotion (surrogate key)',
    -- Technical fields			
	REJECT_REASON_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG						SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG						SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS					TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS					TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID							INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, RECEIPT_SID, DISCOUNT_SID, DELETED_FG)
)	COMMENT='Preliminary Fact Table on receipt line LidlPlus Promotions'
;