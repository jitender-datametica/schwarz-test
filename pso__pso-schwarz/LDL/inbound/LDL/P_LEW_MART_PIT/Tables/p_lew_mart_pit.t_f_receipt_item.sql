/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_RECEIPT_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2021-07-01 Andreas Kurz   Initial version
# 1.1 2021-08-24 Mike Davis     Checks, formatting, FK support (now removed)
# 1.2 2022-01-24 Andreas Kurz	Reworked the structure after DM review
# 1.3 2022-01-26 Andreas Kurz	Added automtically created Flags based on TransactionTypeCode
# 1.4 2022-01-26 Dirk Hering	Changed, added automatically created Flags based on TransactionTypeCode
# 1.5 2022-02-02 Andreas Kurz	Added PIT_DISCOUNT_SALES_QTY_FG to the generated Flags
# 1.6 2022-03-31 Aparna Rayanki Added REAL_PROMOTION Flags
# 1.7 2022-08-12 Dirk Hering    Corrected EFF_PRICE_GROSS, _NET by removing returns (Azure workitem 341226)
# 1.8 2023-03-18 Andreas Kurz 	Added more LP / PD WAWI Calculations Inkrement 2
# 1.9 2024-07-04 Andreas Kurz	Dropped and cleaned list of necessary attributes
# 2.0 2024-11-28 Andreas Kurz	Removed Attributes PREV_DAY_DT, ITEM_UNIT_PRICE_PREV_DAY --> moved to t_f_store_adv_period_item_adv_wawi_pv
# 2.1 2025-05-14 Nikolai Toknov Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_LP_SID					INTEGER																	COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_PD_SID	                INTEGER																	COMMENT 'PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_SID                INTEGER																	COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_LP_SID             INTEGER																	COMMENT 'WAWI_LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_LP_PD_SID          INTEGER																	COMMENT 'WAWI_LP_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_PD_SID             INTEGER																	COMMENT 'WAWI_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_PD_ONLY_SID             INTEGER																	COMMENT 'PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_LP_ONLY_SID		        INTEGER																	COMMENT 'LP_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_LP_PD_ONLY_SID	        INTEGER																	COMMENT 'LP_PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PV_WAWI_FG					SMALLINT		NOT NULL	DEFAULT -1																	COMMENT 'Flag / Indicator WAWI-PV';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PV_PD_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Promotion Designer (NPPS)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PV_LP_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator LidlPlus(LP)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'LP Return Sales Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'LP Return Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_RETURNS_NET_VAL         NUMBER(38,5) 															COMMENT 'LP Return Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'PD Return Sales Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'PD Return Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_RETURNS_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD Return Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_RETURNS_QTY			NUMBER(38,5) 															COMMENT 'WAWI Return Sales Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_RETURNS_GROSS_VAL     NUMBER(38,5) 															COMMENT 'WAWI Return Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_RETURNS_NET_VAL	    NUMBER(38,5) 															COMMENT 'WAWI Return Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_SALES_QTY				NUMBER(38,5) 															COMMENT 'LP Sales Quantity Abverkauf';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'LP Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_SALES_NET_VAL	        NUMBER(38,5) 															COMMENT 'LP Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_SALES_QTY				NUMBER(38,5) 															COMMENT 'PD Sales Quantity Abverkauf';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'PD Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_SALES_QTY				NUMBER(38,5) 															COMMENT 'WAWI Sales Quantity Abverkauf';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_SALES_GROSS_VAL       NUMBER(38,5) 															COMMENT 'WAWI Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'WAWI Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'LP Discount Sales Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'LP Discount Sales Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'LP Discount Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'LP Discount Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'PD Discount Sales Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'PD Discount Sales Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'PD Discount Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'PD Discount Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_SALES_QTY    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_GROSS_VAL    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_NET_VAL      NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP ITEM_PROMO_DESIGNER_FG				;

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  TURNOVER_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  TURNOVER_NET_VAL		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  TURNOVER_GROSS_VAL	;		
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  SALES_PRICE_GROSS		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  SALES_PRICE_NET		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  EFF_PRICE_GROSS		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  EFF_PRICE_NET			;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  ITEM_SAME_PRICE_FG	;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  CHEAPER_FACTOR		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  PV_CALCULATED_VAL	;	
																		
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  TURNOVER_QTY		NUMBER(38,5)	COMMENT ' Calcualted Quantity  Sales + Returns (adjusted)';	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  TURNOVER_NET_VAL	NUMBER(38,5)	COMMENT ' Calcualted Net Value Sales + Returns (adjusted)';	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  TURNOVER_GROSS_VAL	NUMBER(38,5)	COMMENT ' Calcualted Gross Value Sales + Returns (adjusted)';		
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  SALES_PRICE_GROSS	NUMBER(38,5)	COMMENT ' Sales Price Gross (Brutto) - unbereinigt';	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  SALES_PRICE_NET	NUMBER(38,5)	COMMENT ' Sales Price Net (Brutto) - unbereinigt';	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  EFF_PRICE_GROSS	NUMBER(38,5)	COMMENT ' Calculated effective Sales Price Gross (Brutto) bereiningt';	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  EFF_PRICE_NET		NUMBER(38,5)	COMMENT ' Calculated effective Sales Price net (Netto) bereinigt';	

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	ITEM_UNIT_PRICE					NUMBER(38,5)															COMMENT 'Item Unit Price needed for PV Calculation algortithm';

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_SALES_PRICE_GROSS						NUMBER(38,5)																COMMENT 'LidlPlus Reduced Slaes Price';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_VALID_FG									SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Flag / indicator telling Item Discount is a LidlPlus Discount and needed to be counted';

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_COUPON_NAME								VARCHAR																		COMMENT 'LidlPlus Coupon Name';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_COUPON_PROMO_BENEFIT_TXT					VARCHAR																		COMMENT 'LidlPlus Coupon Benefit Text';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_DISCOUNT_VAL								NUMBER(38,5)																COMMENT 'LidlPlus Coupon Discount Value';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_DISCOUNT_PCT								NUMBER(38,5)																COMMENT 'LidlPlus Coupon Discount in %';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_DISCOUNT_PCT_FACTOR						NUMBER(38,5)																COMMENT 'LidlPlus Coupon Discount in % Factor';

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_WAWI_LP_SID    ;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_WAWI_LP_PD_SID ;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_WAWI_PD_SID    ;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_PD_ONLY_SID    ;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_LP_ONLY_SID		;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_LP_PD_ONLY_SID ;

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_RETURNS_GROSS_VAL   ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_RETURNS_NET_VAL     ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_RETURNS_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_RETURNS_GROSS_VAL   ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_RETURNS_NET_VAL		;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_RETURNS_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_RETURNS_GROSS_VAL ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_RETURNS_NET_VAL	;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_SALES_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_SALES_GROSS_VAL     ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_SALES_NET_VAL	    ;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_SALES_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_SALES_GROSS_VAL     ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_SALES_NET_VAL		;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_SALES_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_SALES_GROSS_VAL   ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_SALES_NET_VAL		;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_SALES_QTY	;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_NET_VAL    ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_SALES_QTY	;  
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_NET_VAL    ;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_SALES_QTY;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_GROSS_VAL;   
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_NET_VAL  ;

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_SALES_PRICE_GROSS					;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_COUPON_NAME							;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_COUPON_PROMO_BENEFIT_TXT				;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_DISCOUNT_VAL							;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_DISCOUNT_PCT							;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_DISCOUNT_PCT_FACTOR					;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_VALID_FG								;

ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_UNIT_PRICE						NUMBER(38,5)																COMMENT 'LP Source: Item LP Unit Price needed for PV Calculation algortithm';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_COUPON_NAME							VARCHAR																		COMMENT 'LP Source: The name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_COUPON_PROMO_BENEFIT_TXT				VARCHAR																		COMMENT 'LP Source: Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field Till:oupons.SalesforceCouponType)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_DISCOUNT_GROSS_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Gross)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_DISCOUNT_NET_VAL					NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Net)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_DISCOUNT_SALES_QTY				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Quantity';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_RETURNS_QTY						NUMBER(38,5) 																COMMENT 'LP Source: LP Return Sales Quantity Returned Goods';


ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_UNIT_PRICE			NUMBER(38,5)															COMMENT 'Item LP Unit Price needed for PV Calculation algortithm';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_DISCOUNT_GROSS_VAL	NUMBER(38,5)															COMMENT 'Item LP Discount Value (Gross)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_DISCOUNT_NET_VAL		NUMBER(38,5)															COMMENT 'Item LP Discount Value (Net)';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_DISCOUNT_SALES_QTY	NUMBER(38,5)															COMMENT 'Item LP Discount Quantity';
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP ITEM_UNIT_PRICE_PREV_DAY;
ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP PREV_DAY_DT;
	ITEM_UNIT_PRICE_PREV_DAY					NUMBER(38,5)																COMMENT 'Item Unit Price (previous day with sale)',
	PREV_DAY_DT									DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Date value of the prev day from which we got the ITEM_UNIT_PRICE_PREV_DAY',


ALTER TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD
	LP_PV_COUPON_TYPE_CD	 					VARCHAR(40) 																COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
	LP_PV_ORIG_COUPON_TYPE_SID					INTEGER																		COMMENT 'Unique identifier of the category in SCRM table promotionhst (surrogate key)',
	LP_PV_COUPON_REDUCED_SALES_PRICE 			NUMBER(38,5) 																COMMENT 'the special price of the product that is linked to the coupon',
	LP_PV_COUPON_DISCOUNT_VAL 					NUMBER(38,5) 																COMMENT 'by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers',
	LP_PV_COUPON_DISCOUNT_PCT 					NUMBER(38,5) 																COMMENT 'by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers',
	LP_PV_COUPON_DISCOUNT_X_CNT 				NUMBER(38,0) 																COMMENT 'how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt',
	LP_PV_COUPON_DISCOUNT_Y_CNT 				NUMBER(38,0) 																COMMENT 'how many pieces the customer gets in case he buys x_cnt',

--	LP_PV_COUPON_DISCOUNT_GROSS_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Gross)',
--	LP_PV_COUPON_DISCOUNT_NET_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Net)',
--	LP_PV_COUPON_DISCOUNT_SALES_QTY				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Quantity',
--	LP_PV_ITEM_RETURNS_QTY						NUMBER(38,5) 																COMMENT 'LP Source: LP Return Sales Quantity Returned Goods',
	LP_PV_COUPON_PROMO_TYPE_SID					INTEGER																		COMMENT 'Unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)',
	LP_PV_COUPON_ORIG_COUPON_TYPE_DESCR			VARCHAR																		COMMENT 'unique code identifying the type of the coupon from ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.';
	*/

CREATE TABLE P_LEW_MART_PIT.T_F_RECEIPT_ITEM CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID									INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Client ID e.g AT=1',
	ITEM_SID									INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Item Variant (Case Size)',
	DAY_DT										DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Day of Sales',
	STORE_SID									INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Unique key Region surrogate key',
	RECEIPT_SID									INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Surrogate Key of Receipt',
	ORIG_ITEM_NR								INTEGER		 																COMMENT 'Item NaN (National Artikel Nummer) Link to Item History',
	
	-- AKU 2023-03-18 ## Added more LP / PD WAWI Calculations ##
	-- RECEIPT_LP_SID								INTEGER																		COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	-- RECEIPT_NPPS_SID	                		INTEGER																		COMMENT 'NPPS Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	-- RECEIPT_WAWI_SID                			INTEGER																		COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	
	-- AKU 2022-01-20 adding additional date / Time info
	-- Additional Date Month Week and Year
	ADV_WEEK_START_DAY_ID						INTEGER			NOT NULL	DEFAULT 1 										COMMENT 'Start Weekday Nbr of. Adv Week. Based on Country Configuration. E.g. Switzerland (CH=4) StartDay ID of Adv. Week. 4 (Thursday)',
	ADV_WEEK_ID									INTEGER			NOT NULL	DEFAULT 888853 									COMMENT 'Adv.Week of the Receipt Date',
		
	MOVING_RECEIPT_DAY_START_NBR				INTEGER			NOT NULL	DEFAULT 1 										COMMENT 'Moving Day Nbr. within a month of the Receipt Day',
	RECEIPT_DAY_OF_WEEK_ID						INTEGER			NOT NULL	DEFAULT 1 										COMMENT 'Weekday Nbr of Receipt Mon::=1,Tue::=2,...,Sun::=7',
	RECEIPT_YEAR_ID								INTEGER			NOT NULL	DEFAULT 8888 									COMMENT 'Calendar Year Nbr of Receipt',
	RECEIPT_MONTH_NBR							INTEGER			NOT NULL	DEFAULT 1 										COMMENT 'Calendar Month Nbr of Receipt. [1..12]',
	RECEIPT_MONTH_ID							INTEGER			NOT NULL	DEFAULT 888812 									COMMENT 'Calendar Month ID of Receipt Format: YYYYMM',
	RECEIPT_WEEK_ID								INTEGER			NOT NULL	DEFAULT 888853 									COMMENT 'Calendar Week ID (based on ISO) Format: YYYYWW',

	-- AKU 2022-01-27 Note only national currency's of the countries are used
	CURR_SID									INTEGER			NOT NULL	DEFAULT -1 										COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country',
	CURR_CD										VARCHAR 																	COMMENT 'Currency Code',

	ITEM_ACTION_TYPE_ID							INTEGER		 															    COMMENT 'Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.',

	ITEM_FA_FG									SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling Item is FA Food Action',
	ITEM_NF_FG									SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling that item NF None-Food',
	ITEM_NP_FG									SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling item Normalsortiment (NP Normalpreis) ',

	-- AKU 2023-03-18 ## Added more LP / PD WAWI Calculations ##
	ITEM_PV_WAWI_FG								SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling item WaWi-PV',
	ITEM_PV_NPPS_FG								SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling item NPPS',
	ITEM_PV_LP_FG								SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling item LidlPlus (LP)',	
	-- AKU 2023-03-18 ## Added more LP / PD WAWI Calculations ##

	ACTION_TYPE_ID								INTEGER																		COMMENT 'Determination of the actions type based on the priorities, Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS',

	REAL_PROMOTION_FA_FG						SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling Item is FA Food Action and advertised in Wawi/ADP',
	REAL_PROMOTION_NF_FG						SMALLINT		NOT NULL	DEFAULT -1 										COMMENT 'Flag / indicator telling that item NF None-Food and advertised in Wawi/ADP',
	REAL_PROMOTION_PV_LP_FG						SMALLINT	 	DEFAULT 0													COMMENT '[Real] Flag / indicator: item is PV_LP',
	REAL_PROMOTION_PV_WAWI_FG					SMALLINT	 	DEFAULT 0													COMMENT '[Real] Flag / indicator: item is PV_WAWI',
	REAL_PROMOTION_PV_NPPS_FG					SMALLINT	 	DEFAULT 0													COMMENT '[Real] Flag / indicator: item is PV_NPPS',
	REAL_NP_FG									SMALLINT		NOT NULL	DEFAULT -1										COMMENT '[Real] Flag / indicator: item is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)',
		
	ITEM_RETURN_FG								SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Flag / Indicator Returned Item ',
	ITEM_DISCOUNT_FG							SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Flag / Indicator Discounted Item ',
	
	-- AKU 2023-03-18 Replaced by ITEM_PV_PD_FG
	--ITEM_PROMO_DESIGNER_FG						SMALLINT		NOT NULL	DEFAULT 0 										COMMENT '[Future Use] Flag / Indicator PROMO_DESIGNER Item ',
	
	ITEM_SALES_QTY								NUMBER(38,5) 																COMMENT 'Sales Quantity Abverkauf',
	ITEM_SALES_NET_VAL							NUMBER(38,5) 																COMMENT 'Sales Amount Net in Local Currency',
	ITEM_SALES_GROSS_VAL						NUMBER(38,5) 																COMMENT 'Sales Amount Gross in Local Currency',
	
	VAT_FACTOR									NUMBER(38,5)				DEFAULT 0 										COMMENT 'Tax Vat Factor e.g. 0,2 for 20%',
	ITEM_UNIT_PRICE								NUMBER(38,5)																COMMENT 'Item Unit Price needed for PV Calculation algortithm',

	ITEM_RETURNS_QTY							NUMBER(38,5) 																COMMENT 'Return Sales Quantity Returned Goods',
	ITEM_RETURNS_NET_VAL						NUMBER(38,5) 																COMMENT 'Return Sales Amount Net in Local Currency',
	ITEM_RETURNS_GROSS_VAL						NUMBER(38,5) 																COMMENT 'Return Sales Amount Gross in Local Currency',
								
	ITEM_DISCOUNT_QTY							NUMBER(38,5) 																COMMENT 'Discount Quantity',
	ITEM_DISCOUNT_SALES_QTY						NUMBER(38,5)																COMMENT 'Discount Sales Quantity',							
	ITEM_DISCOUNT_NET_VAL						NUMBER(38,5) 																COMMENT 'Discount Sales Amount Net in Local Currency',
	ITEM_DISCOUNT_GROSS_VAL						NUMBER(38,5) 																COMMENT 'Discount Sales Amount Gross in Local Currency',

	-- AKU 2024-03-19	
	TURNOVER_QTY								NUMBER(38,5)																COMMENT 'Calcualted Quantity Sales + Returns (adjusted)',	
	TURNOVER_NET_VAL							NUMBER(38,5)																COMMENT 'Calcualted Net Value Sales + Returns (adjusted)',	
	TURNOVER_GROSS_VAL							NUMBER(38,5)																COMMENT 'Calcualted Gross Value Sales + Returns (adjusted)',
	SALES_PRICE_GROSS							NUMBER(38,5)																COMMENT 'Sales Price Gross (Brutto) - unbereinigt',
	SALES_PRICE_NET								NUMBER(38,5)																COMMENT 'Sales Price Net (Brutto) - unbereinigt',
	EFF_PRICE_GROSS								NUMBER(38,5)																COMMENT 'Calculated effective Sales Price Gross (Brutto) bereiningt',
	EFF_PRICE_NET								NUMBER(38,5)																COMMENT 'Calculated effective Sales Price net (Netto) bereinigt',

	-- LP 
	LP_PV_ITEM_UNIT_PRICE						NUMBER(38,5)																COMMENT 'LP Source: Item LP Unit Price needed for PV Calculation algortithm',	
	LP_PV_COUPON_TYPE_CD	 					VARCHAR(40) 																COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
	LP_PV_ORIG_COUPON_TYPE_SID					INTEGER																		COMMENT 'Unique identifier of the category in SCRM table promotionhst (surrogate key)',

	LP_PV_COUPON_NAME							VARCHAR																		COMMENT 'LP Source: The name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)',
	LP_PV_COUPON_REDUCED_SALES_PRICE 			NUMBER(38,5) 																COMMENT 'the special price of the product that is linked to the coupon',
	LP_PV_COUPON_DISCOUNT_VAL 					NUMBER(38,5) 																COMMENT 'by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers',
	LP_PV_COUPON_DISCOUNT_PCT 					NUMBER(38,5) 																COMMENT 'by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers',
	LP_PV_COUPON_DISCOUNT_X_CNT 				NUMBER(38,0) 																COMMENT 'how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt',
	LP_PV_COUPON_DISCOUNT_Y_CNT 				NUMBER(38,0) 																COMMENT 'how many pieces the customer gets in case he buys x_cnt',

--	LP_PV_COUPON_DISCOUNT_GROSS_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Gross)',
--	LP_PV_COUPON_DISCOUNT_NET_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Net)',
--	LP_PV_COUPON_DISCOUNT_SALES_QTY				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Quantity',
--	LP_PV_ITEM_RETURNS_QTY						NUMBER(38,5) 																COMMENT 'LP Source: LP Return Sales Quantity Returned Goods',
	LP_PV_COUPON_PROMO_TYPE_SID					INTEGER																		COMMENT 'Unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)',
	LP_PV_COUPON_PROMO_BENEFIT_TXT				VARCHAR																		COMMENT 'LP Source: Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field TillCoupons.SalesforceCouponType)',
	LP_PV_COUPON_ORIG_COUPON_TYPE_DESCR			VARCHAR																		COMMENT 'unique code identifying the type of the coupon from ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',

	LP_PV_ITEM_DISCOUNT_GROSS_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Gross)',
	LP_PV_ITEM_DISCOUNT_NET_VAL					NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Net)',
	LP_PV_ITEM_DISCOUNT_SALES_QTY				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Quantity',

	LP_PV_ITEM_RETURNS_QTY						NUMBER(38,5) 																COMMENT 'LP Source: LP Return Sales Quantity Returned Goods',
	
    -- AKU 20210802 Added 
	CHERRY_PICKER_RECEIPT_ITEM_FG				SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Receipt have characteristic of Chery Picker on item level',

	-- AKU 2022-01-26 Adding automatically created Flags based on TransactionTypeCodes Debugging purpose
	PIT_ADV_ITEM_CNT_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_VAL_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_QTY_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_SALES_QTY_FG					SMALLINT		NOT NULL	DEFAULT -1										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_POS_GKDOS_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_PRICE_RETAIL_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RECEIPT_CNT_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISTINCT_RECEIPT_CNT_FG					SMALLINT		NOT NULL	DEFAULT -1										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',	
	PIT_RETURN_VAL_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_QTY_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_RECEIPT_CNT_FG					SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_SALES_VAL_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_SALES_QTY_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_STORE_CNT_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_TURNOVER_VAL_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_TURNOVER_QTY_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_VOID_VAL_FG								SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_VOID_QTY_FG								SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_WRITE_OFF_FG							SMALLINT		NOT NULL	DEFAULT -1 										COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',

    -- Technical fields
	REJECT_REASON_ID							INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG									SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID							INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG									SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS								TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS								TIMESTAMP		 															COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID										INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, RECEIPT_SID, DELETED_FG)
)	COMMENT='Intermediate Fact Table on receipt line'
;