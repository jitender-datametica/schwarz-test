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
# 1.1 2022-01-14 Aparna Rayanki Changed datatype of RECEIPT_SID from Number to Varchar
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

ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_LP_SID					INTEGER																	COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_PD_SID	                INTEGER																	COMMENT 'PD_2 Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_SID                INTEGER																	COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_LP_SID             INTEGER																	COMMENT 'WAWI_LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_LP_PD_SID          INTEGER																	COMMENT 'WAWI_LP_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_WAWI_PD_SID             INTEGER																	COMMENT 'WAWI_PD Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_PD_ONLY_SID             INTEGER																	COMMENT 'PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_LP_ONLY_SID		        INTEGER																	COMMENT 'LP_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD RECEIPT_LP_PD_ONLY_SID	        INTEGER																	COMMENT 'LP_PD_ONLY Surrogate Key of Receipt Calcualted by MD5(STORE_SID;REGISTER_ID;RECEIPT_TMSP) within Source View';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD DISCOUNT_SID					INTEGER																	COMMENT 'DISCOUNT SID Number';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PV_PD_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Returned Item_2 ';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PV_LP_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Returned Item_2 ';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_RETURNS_NET_VAL         NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_RETURNS_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_RETURNS_QTY			NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_RETURNS_GROSS_VAL     NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_RETURNS_NET_VAL	    NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_SALES_QTY				NUMBER(38,5) 															COMMENT 'LP Sales_2 Quantity Abverkauf';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'LP Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_SALES_NET_VAL	        NUMBER(38,5) 															COMMENT 'LP Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_SALES_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Quantity Abverkauf';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_SALES_QTY				NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Quantity Abverkauf';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_SALES_GROSS_VAL       NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_LP_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_PD_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Gross in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity Returned Goods';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_SALES_QTY    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_GROSS_VAL    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD ITEM_WAWI_DISCOUNT_NET_VAL      NUMBER(38,5) 
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP ITEM_PROMO_DESIGNER_FG				;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD	ITEM_UNIT_PRICE					NUMBER(38,5)															COMMENT 'Item_2 Unit_2 Price needed for PV Calculation algortithm';

ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_WAWI_LP_SID    ;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_WAWI_LP_PD_SID ;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_WAWI_PD_SID    ;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_PD_ONLY_SID    ;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_LP_ONLY_SID		;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		RECEIPT_LP_PD_ONLY_SID ;
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP		DISCOUNT_SID;

ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_UNIT_PRICE			NUMBER(38,5)															COMMENT 'Item_2 LP Unit_2 Price needed for PV Calculation algortithm';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_DISCOUNT_GROSS_VAL	NUMBER(38,5)															COMMENT 'Item_2 LP Discount Value (Gross)';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_DISCOUNT_NET_VAL		NUMBER(38,5)															COMMENT 'Item_2 LP Discount Value (Net)';
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 ADD LP_ITEM_DISCOUNT_SALES_QTY	NUMBER(38,5)															COMMENT 'Item_2 LP Discount Quantity';

ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_RETURNS_GROSS_VAL   ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_RETURNS_NET_VAL     ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_RETURNS_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_RETURNS_GROSS_VAL   ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_RETURNS_NET_VAL		;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_RETURNS_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_RETURNS_GROSS_VAL ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_RETURNS_NET_VAL	;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_SALES_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_SALES_GROSS_VAL     ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_SALES_NET_VAL	    ;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_SALES_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_SALES_GROSS_VAL     ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_SALES_NET_VAL		;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_SALES_QTY			;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_SALES_GROSS_VAL   ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_SALES_NET_VAL		;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_SALES_QTY	;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_LP_DISCOUNT_NET_VAL    ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_SALES_QTY	;  
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_GROSS_VAL  ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_PD_DISCOUNT_NET_VAL    ;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_QTY		;	
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_SALES_QTY;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_GROSS_VAL;   
ALTER TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 DROP	ITEM_WAWI_DISCOUNT_NET_VAL  ;   

*/

CREATE TABLE P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_2 CLUSTER BY (CLIENT_ID, DAY_DT )(
	CLIENT_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g AT=1',
	ITEM_SID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Item_2 Variant (Case Size)',
	DAY_DT							DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Day of Sales_2',
	STORE_SID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique key Region_2 surrogate key',
	RECEIPT_SID						INTEGER			NOT NULL 												COMMENT 'Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	DISCOUNT_SID					INTEGER																	COMMENT 'Technical ID for historicized discount',
	-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##
	-- RECEIPT_LP_SID					INTEGER																	COMMENT 'LP Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	-- RECEIPT_NPPS_SID	            INTEGER																	COMMENT 'NPPS Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
	-- RECEIPT_WAWI_SID                INTEGER																	COMMENT 'WAWI Surrogate Key of Receipt Calcualted by MD5(STORE_SID,REGISTER_ID,RECEIPT_TMSP) within Source View',
																											
	-- ITEM_PV_WAWI_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator WAWI PV Item_2 ',
	-- ITEM_PV_NPPS_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Promotion Designer Item_2 ',
	-- ITEM_PV_LP_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator LP Item_2 ',
	-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##

	-- AKU 2022-01-20 adding additional			DATE / Time info
	-- Additional			DATE Month Week and Year
	ADV_WEEK_START_DAY_ID			INTEGER			NOT NULL	DEFAULT 1 									COMMENT 'Start Weekday Nbr of. Adv Week. Based on Country_2 Configuration. E.g. Switzerland (CH=4) StartDay ID of Adv. Week. 4 (Thursday)',
	ADV_WEEK_ID						INTEGER			NOT NULL												COMMENT 'Adv.Week of the Receipt DATE',
		
	MOVING_RECEIPT_DAY_START_NBR	INTEGER			NOT NULL	DEFAULT 1 									COMMENT 'Moving Day Nbr. within a month of the Receipt Day',
		
	RECEIPT_DAY_OF_WEEK_ID			INTEGER			NOT NULL	DEFAULT 1 									COMMENT 'Weekday Nbr of Receipt Mon::=1,Tue::=2,...,Sun::=7',
	RECEIPT_YEAR_ID					INTEGER			NOT NULL	DEFAULT 8888 								COMMENT 'Calendar_2 Year Nbr of Receipt',
	RECEIPT_MONTH_NBR				INTEGER			NOT NULL	DEFAULT 1 									COMMENT 'Calendar_2 Month Nbr of Receipt. [1..12]',
	RECEIPT_MONTH_ID				INTEGER			NOT NULL	DEFAULT 888812 								COMMENT 'Calendar_2 Month ID of Receipt Format: YYYYMM',
	RECEIPT_WEEK_ID					INTEGER			NOT NULL	DEFAULT 888853 								COMMENT 'Calendar_2 Week ID (based on ISO) Format: YYYYWW',

	-- AKU 2022-01-27 Note only national currency's of the countries are used
	CURR_SID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country_2',
	CURR_CD							VARCHAR 																COMMENT 'Currency Code',

	-- AKU 2022-01-19 for debugging purposes only RECEIPT_SID must be used
	REGISTER_ID						INTEGER		 															COMMENT 'Register ID (debugging only)',
	RECEIPT_ID						INTEGER		 															COMMENT 'Receipt ID per Register POS-System (debugging only)',
	RECEIPT_DAY_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Receipt DATE',
	RECEIPT_TMSP					TIMESTAMP		 														COMMENT 'Receipt Timestamp',

	ITEM_RETURN_FG					SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Returned Item_2 ',
	ITEM_DISCOUNT_FG				SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / Indicator Discounted Item_2 ',
	
	-- AKU 2023-03-18 Replaced by ITEM_PV_PD_FG
	--ITEM_PROMO_DESIGNER_FG			SMALLINT		NOT NULL	DEFAULT -1 									COMMENT '[Future Use] Flag / Indicator PROMO_DESIGNER Item_2 ',

	-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##	ITEM_LP_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Quantity Returned Goods',
	-- ITEM_LP_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Amount Net in Local Currency',
	-- ITEM_LP_RETURNS_NET_VAL         NUMBER(38,5) 															COMMENT 'LP Return Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_PD_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Quantity Returned Goods',
	-- ITEM_PD_RETURNS_GROSS_VAL       NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Net in Local Currency',
	-- ITEM_PD_RETURNS_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD_2 Return Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_WAWI_RETURNS_QTY			NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Quantity Returned Goods',
	-- ITEM_WAWI_RETURNS_GROSS_VAL     NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Net in Local Currency',
	-- ITEM_WAWI_RETURNS_NET_VAL	    NUMBER(38,5) 															COMMENT 'WAWI Return Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_LP_SALES_QTY				NUMBER(38,5) 															COMMENT 'LP Sales_2 Quantity Abverkauf',
	-- ITEM_LP_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'LP Sales_2 Amount Net in Local Currency',
	-- ITEM_LP_SALES_NET_VAL	        NUMBER(38,5) 															COMMENT 'LP Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_PD_SALES_QTY				NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Quantity Abverkauf',
	-- ITEM_PD_SALES_GROSS_VAL         NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Amount Net in Local Currency',
	-- ITEM_PD_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'PD_2 Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_WAWI_SALES_QTY				NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Quantity Abverkauf',
	-- ITEM_WAWI_SALES_GROSS_VAL       NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Amount Net in Local Currency',
	-- ITEM_WAWI_SALES_NET_VAL		    NUMBER(38,5) 															COMMENT 'WAWI Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_LP_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity Returned Goods',
	-- ITEM_LP_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',
	-- ITEM_LP_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Amount Net in Local Currency',
	-- ITEM_LP_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'LP Discount Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_PD_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity Returned Goods',
	-- ITEM_PD_DISCOUNT_SALES_QTY	    NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',
	-- ITEM_PD_DISCOUNT_GROSS_VAL      NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Net in Local Currency',
	-- ITEM_PD_DISCOUNT_NET_VAL        NUMBER(38,5) 															COMMENT 'PD_2 Discount Sales_2 Amount Gross in Local Currency',
	-- 
	-- ITEM_WAWI_DISCOUNT_QTY			NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity Returned Goods',
	-- ITEM_WAWI_DISCOUNT_SALES_QTY    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',
	-- ITEM_WAWI_DISCOUNT_GROSS_VAL    NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Amount Net in Local Currency',
	-- ITEM_WAWI_DISCOUNT_NET_VAL      NUMBER(38,5) 															COMMENT 'WAWI Discount Sales_2 Amount Gross in Local Currency',
	-- 
	-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##
	
	ITEM_SALES_QTY					NUMBER(38,5) 															COMMENT 'Sales_2 Quantity Abverkauf',
	ITEM_SALES_NET_VAL				NUMBER(38,5) 															COMMENT 'Sales_2 Amount Net in Local Currency',
	ITEM_SALES_GROSS_VAL			NUMBER(38,5) 															COMMENT 'Sales_2 Amount Gross in Local Currency',

	VAT_FACTOR						NUMBER(38,5)				DEFAULT 0 									COMMENT 'Tax Vat Factor e.g. 0,2 for 20%',

	-- AKU 2024-04-23 Added ITEM_UNIT_PRICE
	ITEM_UNIT_PRICE					NUMBER(38,5)															COMMENT 'Item_2 Unit_2 Price needed for PV Calculation algortithm',
	
	ITEM_RETURNS_QTY				NUMBER(38,5) 															COMMENT 'Return Sales_2 Quantity Returned Goods',
	ITEM_RETURNS_NET_VAL			NUMBER(38,5) 															COMMENT 'Return Sales_2 Amount Net in Local Currency',
	ITEM_RETURNS_GROSS_VAL			NUMBER(38,5) 															COMMENT 'Return Sales_2 Amount Gross in Local Currency',
						
	ITEM_DISCOUNT_QTY				NUMBER(38,5) 															COMMENT 'Discount Sales_2 Quantity Returned Goods',
	ITEM_DISCOUNT_SALES_QTY			NUMBER(38,5) 															COMMENT 'Discount Sales_2 Quantity without Returned Goods - based on the PIT Flag PIT_DISCOUNT_SALES_QTY_FG',
	ITEM_DISCOUNT_NET_VAL			NUMBER(38,5) 															COMMENT 'Discount Sales_2 Amount Net in Local Currency',
	ITEM_DISCOUNT_GROSS_VAL			NUMBER(38,5) 															COMMENT 'Discount Sales_2 Amount Gross in Local Currency',

	PIT_ADV_ITEM_CNT_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_VAL_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_QTY_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISCOUNT_SALES_QTY_FG		SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_POS_GKDOS_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_PRICE_RETAIL_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RECEIPT_CNT_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_DISTINCT_RECEIPT_CNT_FG		SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_VAL_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_QTY_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_RETURN_RECEIPT_CNT_FG		SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_SALES_VAL_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_SALES_QTY_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_STORE_CNT_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_TURNOVER_VAL_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_TURNOVER_QTY_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_VOID_VAL_FG					SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_VOID_QTY_FG					SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',
	PIT_WRITE_OFF_FG				SMALLINT		NOT NULL	DEFAULT -1									COMMENT '[Debug] Automatically generated flag based on the CNTL Table TransactionType Codes (Source View)',

	-- LP 
	-- LP_PV_ITEM_UNIT_PRICE			NUMBER(38,5)															COMMENT 'Source Item_2 LP Unit_2 Price needed for PV Calculation algortithm',	
	-- LP_PV_ITEM_DISCOUNT_GROSS_VAL	NUMBER(38,5)															COMMENT 'Source Item_2 LP Discount Value (Gross)',
	-- LP_PV_ITEM_DISCOUNT_NET_VAL		NUMBER(38,5)															COMMENT 'Source Item_2 LP Discount Value (Net)',
	-- LP_PV_ITEM_DISCOUNT_SALES_QTY	NUMBER(38,5)															COMMENT 'Source Item_2 LP Discount Quantity',
	
    -- Technical fields			
	REJECT_REASON_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG						SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG						SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS					TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS					TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID							INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, RECEIPT_SID, DELETED_FG)
)	COMMENT='Preliminary Fact Table on receipt line'
;