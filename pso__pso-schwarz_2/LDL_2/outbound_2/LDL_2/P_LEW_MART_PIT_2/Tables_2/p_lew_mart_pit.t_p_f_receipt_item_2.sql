/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for P_F_RECEIPT_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2021-10-28 Aparna Rayanki Initial version
# 1.1 2022-01-14 Aparna Rayanki Changed datatype of RECEIPT_SID from Number to STRING
# 1.2 2022-01-24 Andreas Kurz	Reworked the structure after DM review
# 1.3 2022-01-26 Andreas Kurz	Added automtically created Flags based on TransactionTypeCode
# 1.4 2022-01-26 Dirk Hering	Changed, added automatically created Flags based on TransactionTypeCode
# 1.5 2022-02-02 Andreas Kurz	Added PIT_DISCOUNT_SALES_QTY_FG and renamed the Flags to PIT_
#								Added additional fact column ITEM_DISCOUNT_SALES_QTY
# 1.6 2023-03-18 Andreas Kurz 	Added more LP / PD_2 WAWI Calculations Inkrement 2 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;

ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_LP_SID					INTEGER																	COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_PD_SID	                INTEGER																	COMMENT 'PD_2 Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_SID                INTEGER																	COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_LP_SID             INTEGER																	COMMENT 'WAWI_LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_LP_PD_SID          INTEGER																	COMMENT 'WAWI_LP_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_PD_SID             INTEGER																	COMMENT 'WAWI_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_PD_ONLY_SID             INTEGER																	COMMENT 'PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_LP_ONLY_SID		        INTEGER																	COMMENT 'LP_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_LP_PD_ONLY_SID	        INTEGER																	COMMENT 'LP_PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD DISCOUNT_SID					INTEGER																	COMMENT 'DISCOUNT SID Number';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PV_PD_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Returned Item_2 ';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PV_LP_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Returned Item_2 ';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_RETURNS_NET_VAL         NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_RETURNS_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_RETURNS_QTY			NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_RETURNS_GROSS_VAL     NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_RETURNS_NET_VAL	    NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_SALES_QTY				NUMBER(38,5) 															COMMENT 'LP Sales_2 Quantity Abverkauf';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'LP Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_SALES_NET_VAL	        NUMBER(38,5) 															COMMENT 'LP Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_SALES_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Quantity Abverkauf';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_SALES_QTY				NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Quantity Abverkauf';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_SALES_GROSS_VAL       NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Gross in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity Returned Goods';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_SALES_QTY    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_GROSS_VAL    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_NET_VAL      NUMBER(38,5) 
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP ITEM_PROMO_DESIGNER_FG				;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD	ITEM_UNIT_PRICE					NUMBER(38,5)															COMMENT 'Item_2 Unit_2 Price needed for PV Calculation algortithm';

ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_WAWI_LP_SID    ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_WAWI_LP_PD_SID ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_WAWI_PD_SID    ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_PD_ONLY_SID    ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_LP_ONLY_SID		;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_LP_PD_ONLY_SID ;
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		DISCOUNT_SID;

ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_UNIT_PRICE			NUMBER(38,5)															COMMENT 'Item_2 LP Unit_2 Price needed for PV Calculation algortithm';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_DISCOUNT_GROSS_VAL	NUMBER(38,5)															COMMENT 'Item_2 LP Discount Value (Gross)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_DISCOUNT_NET_VAL		NUMBER(38,5)															COMMENT 'Item_2 LP Discount Value (Net)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_DISCOUNT_SALES_QTY	NUMBER(38,5)															COMMENT 'Item_2 LP Discount Quantity';

ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_RETURNS_GROSS_VAL   ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_RETURNS_NET_VAL     ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_RETURNS_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_RETURNS_GROSS_VAL   ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_RETURNS_NET_VAL		;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_RETURNS_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_RETURNS_GROSS_VAL ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_RETURNS_NET_VAL	;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_SALES_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_SALES_GROSS_VAL     ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_SALES_NET_VAL	    ;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_SALES_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_SALES_GROSS_VAL     ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_SALES_NET_VAL		;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_SALES_QTY			;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_SALES_GROSS_VAL   ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_SALES_NET_VAL		;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_SALES_QTY	;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_NET_VAL    ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_SALES_QTY	;  
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_NET_VAL    ;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_QTY		;	
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_SALES_QTY;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_GROSS_VAL;   
ALTER TABLE LDL.P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_NET_VAL  ;   

*/


-- ITEM_WAWI_DISCOUNT_SALES_QTY    NUMERIC(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',

-- 

-- ITEM_LP_DISCOUNT_NET_VAL        NUMERIC(38,5) 															COMMENT 'LP Discount Sales_2 Amount Gross in Local Currency',

-- ITEM_PD_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity Returned Goods',

-- ITEM_WAWI_DISCOUNT_GROSS_VAL    NUMERIC(38,5) 															COMMENT 'WAWI Discount Sales_2 Amount Net in Local Currency',

-- ITEM_WAWI_RETURNS_QTY			NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Quantity Returned Goods',

-- ITEM_PD_DISCOUNT_GROSS_VAL      NUMERIC(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Net in Local Currency',

-- ITEM_WAWI_SALES_NET_VAL		    NUMERIC(38,5) 															COMMENT 'WAWI Sales_2 Amount Gross in Local Currency',

-- ITEM_PD_DISCOUNT_NET_VAL        NUMERIC(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Gross in Local Currency',

-- Additional			DATE Month Week and Year

-- RECEIPT_LP_SID					INTEGER																	COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',

-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##	ITEM_LP_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Quantity Returned Goods',

-- ITEM_WAWI_RETURNS_NET_VAL	    NUMERIC(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Gross in Local Currency',

-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##

-- RECEIPT_WAWI_SID                INTEGER																	COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',

-- ITEM_WAWI_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity Returned Goods',
 -- LP

-- AKU 2022-01-27 Note only national currency's of the countries are used

-- ITEM_LP_SALES_GROSS_VAL         NUMERIC(38,5) 															COMMENT 'LP Sales_2 Amount Net in Local Currency',
 -- 

-- ITEM_PD_SALES_GROSS_VAL         NUMERIC(38,5) 															COMMENT 'PD_2 Sales_2 Amount Net in Local Currency',

-- Technical fields

-- ITEM_PD_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Quantity Returned Goods',

-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##

-- ITEM_WAWI_SALES_GROSS_VAL       NUMERIC(38,5) 															COMMENT 'WAWI Sales_2 Amount Net in Local Currency',

-- AKU 2023-03-18 Replaced by ITEM_PV_PD_FG

-- ITEM_WAWI_RETURNS_GROSS_VAL     NUMERIC(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Net in Local Currency',

-- ITEM_PD_DISCOUNT_SALES_QTY	    NUMERIC(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',

-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##

-- ITEM_PV_LP_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator LP Item_2 ',

-- RECEIPT_NPPS_SID	            INTEGER																	COMMENT 'NPPS Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',

-- AKU 2022-01-20 adding additional			DATE / Time info
 -- 

-- LP_PV_ITEM_DISCOUNT_NET_VAL		NUMBER(38,5)															COMMENT 'Source Item_2 LP Discount Value (Net)',

-- ITEM_PV_NPPS_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Promotion Designer Item_2 ',

-- ITEM_PD_RETURNS_GROSS_VAL       NUMERIC(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Net in Local Currency',

-- LP_PV_ITEM_DISCOUNT_SALES_QTY	NUMBER(38,5)															COMMENT 'Source Item_2 LP Discount Quantity',

-- ITEM_LP_RETURNS_NET_VAL         NUMERIC(38,5) 															COMMENT 'LP Return Sales_2 Amount Gross in Local Currency',

-- 
 -- ITEM_PD_SALES_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Quantity Abverkauf',

-- ITEM_LP_SALES_QTY				NUMBER(38,5) 															COMMENT 'LP Sales_2 Quantity Abverkauf',
 -- 

-- ITEM_LP_DISCOUNT_SALES_QTY	    NUMERIC(38,5) 															COMMENT 'LP Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',

-- ITEM_LP_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity Returned Goods',
 -- 

-- ITEM_LP_RETURNS_GROSS_VAL       NUMERIC(38,5) 															COMMENT 'LP Return Sales_2 Amount Net in Local Currency',

-- ITEM_LP_DISCOUNT_GROSS_VAL      NUMERIC(38,5) 															COMMENT 'LP Discount Sales_2 Amount Net in Local Currency',

-- ITEM_PD_RETURNS_NET_VAL		    NUMERIC(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Gross in Local Currency',

-- AKU 2024-04-23 Added ITEM_UNIT_PRICE

-- ITEM_WAWI_SALES_QTY				NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Quantity Abverkauf',
 -- 

-- ITEM_PV_WAWI_FG					INTEGER NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator WAWI PV Item_2 ',

-- ITEM_LP_SALES_NET_VAL	        NUMERIC(38,5) 															COMMENT 'LP Sales_2 Amount Gross in Local Currency',

-- ITEM_PROMO_DESIGNER_FG			INTEGER NOT NULL	DEFAULT -1 									COMMENT '[Future Use] Flag / Indicator PROMO_DESIGNER Item_2 ',

-- ITEM_WAWI_DISCOUNT_NET_VAL      NUMERIC(38,5) 															COMMENT 'WAWI Discount Sales_2 Amount Gross in Local Currency',

-- AKU 2022-01-19 for debugging purposes only RECEIPT_SID must be used
 -- 

-- LP_PV_ITEM_DISCOUNT_GROSS_VAL	NUMBER(38,5)															COMMENT 'Source Item_2 LP Discount Value (Gross)',

-- LP_PV_ITEM_UNIT_PRICE			NUMBER(38,5)															COMMENT 'Source Item_2 LP Unit_2 Price needed for PV Calculation algortithm',

-- ITEM_PD_SALES_NET_VAL		    NUMERIC(38,5) 															COMMENT 'PD_2 Sales_2 Amount Gross in Local Currency',
 -- 

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_p_f_receipt_item_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_2 Variant (Case Size)'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_2'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_2 surrogate key'),
receipt_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View'),
discount_sid INTEGER OPTIONS(description='Technical ID for historicized discount'),
adv_week_start_day_id INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Start Weekday Nbr of. Adv Week. Based on Country_2 Configuration. E.g. Switzerland (CH=4) StartDay ID of Adv. Week. 4 (Thursday)'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Adv.Week of the Receipt DATE'),
moving_receipt_day_start_nbr INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Moving Day Nbr. within a month of the Receipt Day'),
receipt_day_of_week_id INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Weekday Nbr of Receipt Mon::=1,Tue::=2,...,Sun::=7'),
receipt_year_id INTEGER DEFAULT 8888 NOT NULL OPTIONS(description='Calendar_2 Year Nbr of Receipt'),
receipt_month_nbr INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Calendar_2 Month Nbr of Receipt. [1..12]'),
receipt_month_id INTEGER DEFAULT 888812 NOT NULL OPTIONS(description='Calendar_2 Month ID of Receipt Format: YYYYMM'),
receipt_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Calendar_2 Week ID (based on ISO) Format: YYYYWW'),
curr_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country_2'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
register_id INTEGER OPTIONS(description='Register ID (debugging only)'),
receipt_id INTEGER OPTIONS(description='Receipt ID per Register POS-System (debugging only)'),
receipt_day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Receipt DATE'),
receipt_tmsp DATETIME OPTIONS(description='Receipt Timestamp'),
item_return_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / Indicator Returned Item_2 '),
item_discount_fg INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Flag / Indicator Discounted Item_2 '),
item_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Quantity Abverkauf'),
item_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Net in Local Currency'),
item_sales_gross_val BIGNUMERIC(38,5) OPTIONS(description='Sales_2 Amount Gross in Local Currency'),
vat_factor BIGNUMERIC(38,5) DEFAULT 0 OPTIONS(description='Tax Vat Factor e.g. 0,2 for 20%'),
item_unit_price BIGNUMERIC(38,5) OPTIONS(description='Item_2 Unit_2 Price needed for PV Calculation algortithm'),
item_returns_qty BIGNUMERIC(38,5) OPTIONS(description='Return Sales_2 Quantity Returned Goods'),
item_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='Return Sales_2 Amount Net in Local Currency'),
item_returns_gross_val BIGNUMERIC(38,5) OPTIONS(description='Return Sales_2 Amount Gross in Local Currency'),
item_discount_qty BIGNUMERIC(38,5) OPTIONS(description='Discount Sales_2 Quantity Returned Goods'),
item_discount_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG'),
item_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Discount Sales_2 Amount Net in Local Currency'),
item_discount_gross_val BIGNUMERIC(38,5) OPTIONS(description='Discount Sales_2 Amount Gross in Local Currency'),
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
OPTIONS(description='Preliminary Fact Table on receipt line');