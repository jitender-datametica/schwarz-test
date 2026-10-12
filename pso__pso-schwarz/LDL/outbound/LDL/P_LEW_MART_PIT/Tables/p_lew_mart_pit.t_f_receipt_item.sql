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

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_LP_SID					INTEGER																	COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_PD_SID	                INTEGER																	COMMENT 'PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_SID                INTEGER																	COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_LP_SID             INTEGER																	COMMENT 'WAWI_LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_LP_PD_SID          INTEGER																	COMMENT 'WAWI_LP_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_WAWI_PD_SID             INTEGER																	COMMENT 'WAWI_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_PD_ONLY_SID             INTEGER																	COMMENT 'PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_LP_ONLY_SID		        INTEGER																	COMMENT 'LP_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD RECEIPT_LP_PD_ONLY_SID	        INTEGER																	COMMENT 'LP_PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PV_WAWI_FG					INTEGER NOT NULL	DEFAULT -1																	COMMENT 'Flag / Indicator WAWI-PV';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PV_PD_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Promotion Designer (NPPS)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PV_LP_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator LidlPlus(LP)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'LP Return Sales Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'LP Return Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_RETURNS_NET_VAL         NUMBER(38,5) 															COMMENT 'LP Return Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'PD Return Sales Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'PD Return Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_RETURNS_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD Return Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_RETURNS_QTY			NUMBER(38,5) 															COMMENT 'WAWI Return Sales Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_RETURNS_GROSS_VAL     NUMBER(38,5) 															COMMENT 'WAWI Return Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_RETURNS_NET_VAL	    NUMBER(38,5) 															COMMENT 'WAWI Return Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_SALES_QTY				NUMBER(38,5) 															COMMENT 'LP Sales Quantity Abverkauf';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'LP Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_SALES_NET_VAL	        NUMBER(38,5) 															COMMENT 'LP Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_SALES_QTY				NUMBER(38,5) 															COMMENT 'PD Sales Quantity Abverkauf';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'PD Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_SALES_QTY				NUMBER(38,5) 															COMMENT 'WAWI Sales Quantity Abverkauf';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_SALES_GROSS_VAL       NUMBER(38,5) 															COMMENT 'WAWI Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'WAWI Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'LP Discount Sales Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'LP Discount Sales Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'LP Discount Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_LP_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'LP Discount Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'PD Discount Sales Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'PD Discount Sales Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'PD Discount Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_PD_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'PD Discount Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_SALES_QTY    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_GROSS_VAL    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD ITEM_WAWI_DISCOUNT_NET_VAL      NUMBER(38,5) 															COMMENT 'WAWI Discount Sales Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP ITEM_PROMO_DESIGNER_FG				;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  TURNOVER_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  TURNOVER_NET_VAL		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  TURNOVER_GROSS_VAL	;		
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  SALES_PRICE_GROSS		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  SALES_PRICE_NET		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  EFF_PRICE_GROSS		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  EFF_PRICE_NET			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  ITEM_SAME_PRICE_FG	;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  CHEAPER_FACTOR		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP  PV_CALCULATED_VAL	;	
																		
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  TURNOVER_QTY		NUMBER(38,5)	COMMENT ' Calcualted Quantity  Sales + Returns (adjusted)';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  TURNOVER_NET_VAL	NUMBER(38,5)	COMMENT ' Calcualted Net Value Sales + Returns (adjusted)';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  TURNOVER_GROSS_VAL	NUMBER(38,5)	COMMENT ' Calcualted Gross Value Sales + Returns (adjusted)';		
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  SALES_PRICE_GROSS	NUMBER(38,5)	COMMENT ' Sales Price Gross (Brutto) - unbereinigt';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  SALES_PRICE_NET	NUMBER(38,5)	COMMENT ' Sales Price Net (Brutto) - unbereinigt';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  EFF_PRICE_GROSS	NUMBER(38,5)	COMMENT ' Calculated effective Sales Price Gross (Brutto) bereiningt';	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD  EFF_PRICE_NET		NUMBER(38,5)	COMMENT ' Calculated effective Sales Price net (Netto) bereinigt';	

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	ITEM_UNIT_PRICE					NUMBER(38,5)															COMMENT 'Item Unit Price needed for PV Calculation algortithm';

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_SALES_PRICE_GROSS						NUMBER(38,5)																COMMENT 'LidlPlus Reduced Slaes Price';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_VALID_FG									INTEGER NOT NULL	DEFAULT 0 										COMMENT 'Flag / indicator telling Item Discount is a LidlPlus Discount and needed to be counted';

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_COUPON_NAME								STRING																		COMMENT 'LidlPlus Coupon Name';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_COUPON_PROMO_BENEFIT_TXT					STRING																		COMMENT 'LidlPlus Coupon Benefit Text';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_DISCOUNT_VAL								NUMBER(38,5)																COMMENT 'LidlPlus Coupon Discount Value';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_DISCOUNT_PCT								NUMBER(38,5)																COMMENT 'LidlPlus Coupon Discount in %';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD	LP_DISCOUNT_PCT_FACTOR						NUMBER(38,5)																COMMENT 'LidlPlus Coupon Discount in % Factor';

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_WAWI_LP_SID    ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_WAWI_LP_PD_SID ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_WAWI_PD_SID    ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_PD_ONLY_SID    ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_LP_ONLY_SID		;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP		RECEIPT_LP_PD_ONLY_SID ;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_RETURNS_GROSS_VAL   ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_RETURNS_NET_VAL     ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_RETURNS_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_RETURNS_GROSS_VAL   ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_RETURNS_NET_VAL		;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_RETURNS_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_RETURNS_GROSS_VAL ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_RETURNS_NET_VAL	;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_SALES_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_SALES_GROSS_VAL     ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_SALES_NET_VAL	    ;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_SALES_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_SALES_GROSS_VAL     ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_SALES_NET_VAL		;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_SALES_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_SALES_GROSS_VAL   ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_SALES_NET_VAL		;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_SALES_QTY	;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_LP_DISCOUNT_NET_VAL    ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_SALES_QTY	;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_PD_DISCOUNT_NET_VAL    ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_SALES_QTY;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_GROSS_VAL;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP	ITEM_WAWI_DISCOUNT_NET_VAL  ;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_SALES_PRICE_GROSS					;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_COUPON_NAME							;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_COUPON_PROMO_BENEFIT_TXT				;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_DISCOUNT_VAL							;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_DISCOUNT_PCT							;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_DISCOUNT_PCT_FACTOR					;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP LP_VALID_FG								;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_UNIT_PRICE						NUMBER(38,5)																COMMENT 'LP Source: Item LP Unit Price needed for PV Calculation algortithm';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_COUPON_NAME							STRING																		COMMENT 'LP Source: The name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_COUPON_PROMO_BENEFIT_TXT				STRING																		COMMENT 'LP Source: Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field Till:oupons.SalesforceCouponType)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_DISCOUNT_GROSS_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Gross)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_DISCOUNT_NET_VAL					NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Net)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_DISCOUNT_SALES_QTY				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Quantity';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM  ADD	LP_PV_ITEM_RETURNS_QTY						NUMBER(38,5) 																COMMENT 'LP Source: LP Return Sales Quantity Returned Goods';


ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_UNIT_PRICE			NUMBER(38,5)															COMMENT 'Item LP Unit Price needed for PV Calculation algortithm';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_DISCOUNT_GROSS_VAL	NUMBER(38,5)															COMMENT 'Item LP Discount Value (Gross)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_DISCOUNT_NET_VAL		NUMBER(38,5)															COMMENT 'Item LP Discount Value (Net)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD LP_ITEM_DISCOUNT_SALES_QTY	NUMBER(38,5)															COMMENT 'Item LP Discount Quantity';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP ITEM_UNIT_PRICE_PREV_DAY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM DROP PREV_DAY_DT;
	ITEM_UNIT_PRICE_PREV_DAY					NUMBER(38,5)																COMMENT 'Item Unit Price (previous day with sale)',
	PREV_DAY_DT									DATE			NOT NULL	DEFAULT DATE '8888-12-31' 	COMMENT 'Date value of the prev day from which we got the ITEM_UNIT_PRICE_PREV_DAY',


ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_ITEM ADD
	LP_PV_COUPON_TYPE_CD	 					STRING(40) 																COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
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
	LP_PV_COUPON_ORIG_COUPON_TYPE_DESCR			STRING																		COMMENT 'unique code identifying the type of the coupon from LDL.ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.';
	*/


-- AKU 2022-01-20 adding additional date / Time info
 -- AKU 2023-03-18 ## Added more LP / PD WAWI Calculations ##

-- ITEM_PROMO_DESIGNER_FG						INTEGER NOT NULL	DEFAULT 0 										COMMENT '[Future Use] Flag / Indicator PROMO_DESIGNER Item ',

-- LP_PV_COUPON_DISCOUNT_NET_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Net)',

-- AKU 2023-03-18 ## Added more LP / PD WAWI Calculations ##

-- RECEIPT_WAWI_SID                			INTEGER																		COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',

-- AKU 20210802 Added
 -- LP

-- LP_PV_COUPON_DISCOUNT_SALES_QTY				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Quantity',

-- AKU 2022-01-27 Note only national currency's of the countries are used

-- LP_PV_COUPON_DISCOUNT_GROSS_VAL				NUMBER(38,5)																COMMENT 'LP Source: Item LP Discount Value (Gross)',

-- AKU 2023-03-18 ## Added more LP / PD WAWI Calculations ##

-- RECEIPT_NPPS_SID	                		INTEGER																		COMMENT 'NPPS Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',

-- Technical fields

-- RECEIPT_LP_SID								INTEGER																		COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',

-- AKU 2023-03-18 Replaced by ITEM_PV_PD_FG
 -- AKU 2024-03-19

-- LP_PV_ITEM_RETURNS_QTY						NUMBER(38,5) 																COMMENT 'LP Source: LP Return Sales Quantity Returned Goods',

-- Additional Date Month Week and Year

-- AKU 2022-01-26 Adding automatically created Flags based on TransactionTypeCodes Debugging purpose
 CREATE TABLE
IF NOT EXISTS ldl_p_lew_mart_pit.t_f_receipt_item (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item Variant (Case Size)'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region surrogate key'),
receipt_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Surrogate Key of Receipt'),
orig_item_nr INTEGER OPTIONS(description='Item NaN (National Artikel Nummer) Link to Item History'),
adv_week_start_day_id INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Start Weekday Nbr of. Adv Week. Based on Country Configuration. E.g. Switzerland (CH=4) StartDay ID of Adv. Week. 4 (Thursday)'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Adv.Week of the Receipt Date'),
moving_receipt_day_start_nbr INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Moving Day Nbr. within a month of the Receipt Day'),
receipt_day_of_week_id INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Weekday Nbr of Receipt Mon::=1,Tue::=2,...,Sun::=7'),
receipt_year_id INTEGER DEFAULT 8888 NOT NULL OPTIONS(description='Calendar Year Nbr of Receipt'),
receipt_month_nbr INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Calendar Month Nbr of Receipt. [1..12]'),
receipt_month_id INTEGER DEFAULT 888812 NOT NULL OPTIONS(description='Calendar Month ID of Receipt Format: YYYYMM'),
receipt_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Calendar Week ID (based on ISO) Format: YYYYWW'),
curr_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
item_action_type_id INTEGER
OPTIONS(description='Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.'),
item_fa_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling Item is FA Food Action'),
item_nf_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling that item NF None-Food'),
item_np_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / indicator telling item Normalsortiment (NP Normalpreis) '),
item_pv_wawi_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling item WaWi-PV'),
item_pv_npps_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling item NPPS'),
item_pv_lp_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / indicator telling item LidlPlus (LP)'),
action_type_id INTEGER
OPTIONS(description='Determination of the actions type based on the priorities, Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS'),
real_promotion_fa_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / indicator telling Item is FA Food Action and advertised in Wawi/ADP'),
real_promotion_nf_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / indicator telling that item NF None-Food and advertised in Wawi/ADP'),
real_promotion_pv_lp_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item is PV_LP'),
real_promotion_pv_wawi_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item is PV_WAWI'),
real_promotion_pv_npps_fg INTEGER DEFAULT 0 OPTIONS(description='[Real] Flag / indicator: item is PV_NPPS'),
real_np_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Real] Flag / indicator: item is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::INTEGER ,0::INTEGER )'),
item_return_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / Indicator Returned Item '),
item_discount_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / Indicator Discounted Item '),
item_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales Quantity Abverkauf'),
item_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales Amount Net in Local Currency'),
item_sales_gross_val BIGNUMERIC(38,5) OPTIONS(description='Sales Amount Gross in Local Currency'),
vat_factor BIGNUMERIC(38,5) DEFAULT 0 OPTIONS(description='Tax Vat Factor e.g. 0,2 for 20%'),
item_unit_price BIGNUMERIC(38,5) OPTIONS(description='Item Unit Price needed for PV Calculation algortithm'),
item_returns_qty BIGNUMERIC(38,5) OPTIONS(description='Return Sales Quantity Returned Goods'),
item_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='Return Sales Amount Net in Local Currency'),
item_returns_gross_val BIGNUMERIC(38,5) OPTIONS(description='Return Sales Amount Gross in Local Currency'),
item_discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discount Quantity'),
item_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Discount Sales Quantity'),
item_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Discount Sales Amount Net in Local Currency'),
item_discount_gross_val BIGNUMERIC(38,5) OPTIONS(description='Discount Sales Amount Gross in Local Currency'),
turnover_qty BIGNUMERIC(38,5) OPTIONS(description='Calcualted Quantity Sales + Returns (adjusted)'),
turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Net Value Sales + Returns (adjusted)'),
turnover_gross_val BIGNUMERIC(38,5) OPTIONS(description='Calcualted Gross Value Sales + Returns (adjusted)'),
sales_price_gross BIGNUMERIC(38,5) OPTIONS(description='Sales Price Gross (Brutto) - unbereinigt'),
sales_price_net BIGNUMERIC(38,5) OPTIONS(description='Sales Price Net (Brutto) - unbereinigt'),
eff_price_gross BIGNUMERIC(38,5) OPTIONS(description='Calculated effective Sales Price Gross (Brutto) bereiningt'),
eff_price_net BIGNUMERIC(38,5) OPTIONS(description='Calculated effective Sales Price net (Netto) bereinigt'),
lp_pv_item_unit_price BIGNUMERIC(38,5)
OPTIONS(description='LP Source: Item LP Unit Price needed for PV Calculation algortithm'),
lp_pv_coupon_type_cd STRING(40)
OPTIONS(description='unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.'),
lp_pv_orig_coupon_type_sid INTEGER
OPTIONS(description='Unique identifier of the category in SCRM table promotionhst (surrogate key)'),
lp_pv_coupon_name STRING(16777216)
OPTIONS(description='LP Source: The name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)'),
lp_pv_coupon_reduced_sales_price BIGNUMERIC(38,5)
OPTIONS(description='the special price of the product that is linked to the coupon'),
lp_pv_coupon_discount_val BIGNUMERIC(38,5)
OPTIONS(description='by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers'),
lp_pv_coupon_discount_pct BIGNUMERIC(38,5)
OPTIONS(description='by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers'),
lp_pv_coupon_discount_x_cnt BIGNUMERIC(38,0)
OPTIONS(description='how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt'),
lp_pv_coupon_discount_y_cnt BIGNUMERIC(38,0)
OPTIONS(description='how many pieces the customer gets in case he buys x_cnt'),
lp_pv_coupon_promo_type_sid INTEGER
OPTIONS(description='Unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)'),
lp_pv_coupon_promo_benefit_txt STRING(16777216)
OPTIONS(description='LP Source: Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field TillCoupons.SalesforceCouponType)'),
lp_pv_coupon_orig_coupon_type_descr STRING(16777216)
OPTIONS(description='unique code identifying the type of the coupon from LDL.ref.table, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.'),
lp_pv_item_discount_gross_val BIGNUMERIC(38,5) OPTIONS(description='LP Source: Item LP Discount Value (Gross)'),
lp_pv_item_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='LP Source: Item LP Discount Value (Net)'),
lp_pv_item_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='LP Source: Item LP Discount Quantity'),
lp_pv_item_returns_qty BIGNUMERIC(38,5) OPTIONS(description='LP Source: LP Return Sales Quantity Returned Goods'),
cherry_picker_receipt_item_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Receipt have characteristic of Chery Picker on item level'),
pit_adv_item_cnt_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_discount_val_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_discount_qty_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_discount_sales_qty_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_pos_gkdos_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_price_retail_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_receipt_cnt_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_distinct_receipt_cnt_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_return_val_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_return_qty_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_return_receipt_cnt_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_sales_val_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_sales_qty_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_store_cnt_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_turnover_val_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_turnover_qty_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_void_val_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_void_qty_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
pit_write_off_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)'),
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
PRIMARY KEY (client_id, day_dt, store_sid, item_sid, receipt_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Intermediate Fact Table on receipt line');