/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_RECEIPT
# Interface : DDL for F_RECEIPT
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table Receipt
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-02 Andreas Kurz    	Added further columns cherry / heavy
#                                  	Exclusive Buyer Receipt Flag/Idicator
#  1.2  2021-08-24 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.3  2022-02-21 Aparna Rayanki  	removed discount_sales_qty from TurnOVER to align Sales_2 Quantity with Lead
#  1.4  2022-02-24 Andreas Kurz		Added CLuster Key
#  1.5 	2023-03-18 Andreas Kurz 	Added more LP / PD_2 WAWI Calculations Inkrement 2
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	DISTINCT_WAWI_ORIG_ITEM_NR_CNT		NUMBER(38,0) 																	COMMENT 'Number of distinct items which are WAWI-PV per Bon';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	DISTINCT_PD_ORIG_ITEM_NR_CNT		NUMBER(38,0) 																	COMMENT 'Number of distinct items which are PD_2-PV per Bon';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	DISTINCT_LP_ORIG_ITEM_NR_CNT		NUMBER(38,0) 																	COMMENT 'Number of distinct items which are LP-PV per Bon';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_SALES_QTY					NUMBER(38,5) 																COMMENT 'WAWI PV Sales_2 Quantity (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_SALES_NET_VAL				NUMBER(38,5) 																COMMENT 'WAWI PV Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_RETURNS_QTY					NUMBER(38,5) 																COMMENT 'WAWI PV Sales_2 Quantity Returns (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_RETURNS_NET_VAL				NUMBER(38,5) 																COMMENT 'WAWI PV Returns Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_DISCOUNT_QTY				NUMBER(38,5) 																COMMENT 'WAWI PV Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_DISCOUNT_SALES_QTY			NUMBER(38,5)											                    COMMENT 'WAWI PV Sales_2 Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_DISCOUNT_NET_VAL			NUMBER(38,5) 																COMMENT 'WAWI PV Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_TURNOVER_QTY				NUMBER(38,5) 																COMMENT 'WAWI PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	WAWI_PV_TURNOVER_NET_VAL			NUMBER(38,5) 																COMMENT 'WAWI PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_SALES_QTY						NUMBER(38,5) 																COMMENT 'LP PV Sales_2 Quantity (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_SALES_NET_VAL					NUMBER(38,5) 																COMMENT 'LP PV Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_RETURNS_QTY					NUMBER(38,5) 																COMMENT 'LP PV Sales_2 Quantity Returns (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_RETURNS_NET_VAL				NUMBER(38,5) 																COMMENT 'LP PV Returns Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_DISCOUNT_QTY					NUMBER(38,5) 																COMMENT 'LP PV Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_DISCOUNT_SALES_QTY			NUMBER(38,5)											                    COMMENT 'LP PV Sales_2 Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_DISCOUNT_NET_VAL				NUMBER(38,5) 																COMMENT 'LP PV Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_TURNOVER_QTY					NUMBER(38,5) 																COMMENT 'LP PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	LP_PV_TURNOVER_NET_VAL				NUMBER(38,5) 																COMMENT 'LP PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_SALES_QTY						NUMBER(38,5) 																COMMENT 'PD_2 PV Sales_2 Quantity (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_SALES_NET_VAL					NUMBER(38,5) 																COMMENT 'PD_2 PV Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_RETURNS_QTY					NUMBER(38,5) 																COMMENT 'PD_2 PV Sales_2 Quantity Returns (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_RETURNS_NET_VAL				NUMBER(38,5) 																COMMENT 'PD_2 PV Returns Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_DISCOUNT_QTY					NUMBER(38,5) 																COMMENT 'PD_2 PV Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_DISCOUNT_SALES_QTY			NUMBER(38,5)											                    COMMENT 'PD_2 PV Sales_2 Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_DISCOUNT_NET_VAL				NUMBER(38,5) 																COMMENT 'PD_2 PV Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_TURNOVER_QTY					NUMBER(38,5) 																COMMENT 'PD_2 PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD	PD_PV_TURNOVER_NET_VAL				NUMBER(38,5) 																COMMENT 'PD_2 PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP DISTINCT_PROMO_DESIGNER_ORIG_ITEM_NR_CNT;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP LIDL_PLUS_FG;

--PV 20240326
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PV_TURNOVER_QTY TO PV_TURNOVER_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PV_TURNOVER_NET_VAL TO PV_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PV_TURNOVER_QTY NUMBER(38,5) COMMENT 'For PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'; 
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PV_TURNOVER_NET_VAL NUMBER(38,5) COMMENT 'For PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET PV_TURNOVER_QTY = COALESCE(PV_SALES_QTY, 0.00) + COALESCE(PV_RETURNS_QTY, 0.00)
WHERE CLIENT_ID = 32;
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET PV_TURNOVER_NET_VAL = COALESCE(PV_SALES_NET_VAL, 0.00) + COALESCE(PV_RETURNS_NET_VAL, 0.00)
WHERE CLIENT_ID = 32;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PV_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PV_TURNOVER_QTY_BCK;

--NF
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NF_TURNOVER_QTY TO NF_TURNOVER_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NF_TURNOVER_NET_VAL TO NF_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NF_TURNOVER_QTY NUMBER(38,5) COMMENT 'For NF-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'; 
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NF_TURNOVER_NET_VAL NUMBER(38,5) COMMENT 'For NF-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET NF_TURNOVER_QTY = COALESCE(NF_SALES_QTY, 0.00) + COALESCE(NF_RETURNS_QTY, 0.00)
WHERE CLIENT_ID = 32;
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET NF_TURNOVER_NET_VAL = COALESCE(NF_SALES_NET_VAL, 0.00) + COALESCE(NF_RETURNS_NET_VAL, 0.00)
WHERE CLIENT_ID = 32;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NF_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NF_TURNOVER_QTY_BCK;

--FA
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN FA_TURNOVER_QTY TO FA_TURNOVER_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN FA_TURNOVER_NET_VAL TO FA_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD FA_TURNOVER_QTY NUMBER(38,5) COMMENT 'For FA-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'; 
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD FA_TURNOVER_NET_VAL NUMBER(38,5) COMMENT 'For FA-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET FA_TURNOVER_QTY = COALESCE(FA_SALES_QTY, 0.00) + COALESCE(FA_RETURNS_QTY, 0.00)
WHERE CLIENT_ID = 32;
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET FA_TURNOVER_NET_VAL = COALESCE(FA_SALES_NET_VAL, 0.00) + COALESCE(FA_RETURNS_NET_VAL, 0.00)
WHERE CLIENT_ID = 32;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP FA_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP FA_TURNOVER_QTY_BCK;

--TOTAL_RECEIPT_TURNOVER_QTY
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN TOTAL_RECEIPT_TURNOVER_QTY TO TOTAL_RECEIPT_TURNOVER_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN TOTAL_RECEIPT_TURNOVER_NET_VAL TO TOTAL_RECEIPT_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD TOTAL_RECEIPT_TURNOVER_QTY NUMBER(38,5) COMMENT 'For total receopt on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'; 
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD TOTAL_RECEIPT_TURNOVER_NET_VAL NUMBER(38,5) COMMENT 'For total receipt on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET TOTAL_RECEIPT_TURNOVER_QTY = COALESCE(FA_SALES_QTY, 0.00) + COALESCE(FA_RETURNS_QTY, 0.00)
WHERE CLIENT_ID = 32;
UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
SET TOTAL_RECEIPT_TURNOVER_NET_VAL = COALESCE(FA_SALES_NET_VAL, 0.00) + COALESCE(FA_RETURNS_NET_VAL, 0.00)
WHERE CLIENT_ID = 32;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP TOTAL_RECEIPT_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP TOTAL_RECEIPT_TURNOVER_QTY_BCK;

--PROMO_RECEIPT_SALES_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_SALES_QTY TO PROMO_RECEIPT_SALES_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_SALES_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_SALES_QTY NUMBER(38,5)  COMMENT 'Promo Sales_2 Quantity (Abverkauf) per Bon';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_SALES_QTY = ((COALESCE(PV_SALES_QTY, 0)) + (COALESCE(NF_SALES_QTY, 0))) + (COALESCE(FA_SALES_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_SALES_QTY_BCK;

--PROMO_RECEIPT_SALES_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_SALES_NET_VAL TO PROMO_RECEIPT_SALES_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_SALES_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_SALES_NET_VAL NUMBER(38,5)  COMMENT 'Promo Sales_2 Amount Net in Local Currency';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_SALES_NET_VAL = ((COALESCE(PV_SALES_NET_VAL, 0)) + (COALESCE(NF_SALES_NET_VAL, 0))) + (COALESCE(FA_SALES_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_SALES_NET_VAL_BCK;

--PROMO_RECEIPT_RETURNS_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_RETURNS_QTY TO PROMO_RECEIPT_RETURNS_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_RETURNS_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_RETURNS_QTY NUMBER(38,5)  COMMENT 'Promo Sales_2 Quantity Returns (Abverkauf)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_RETURNS_QTY = ((COALESCE(PV_RETURNS_QTY, 0)) + (COALESCE(NF_RETURNS_QTY, 0))) + (COALESCE(FA_RETURNS_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_RETURNS_QTY_BCK;

--PROMO_RECEIPT_RETURNS_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_RETURNS_NET_VAL TO PROMO_RECEIPT_RETURNS_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_RETURNS_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_RETURNS_NET_VAL NUMBER(38,5)  COMMENT 'Promo Returns Sales_2 Amount Net in Local Currency';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_RETURNS_NET_VAL = ((COALESCE(PV_RETURNS_NET_VAL, 0)) + (COALESCE(NF_RETURNS_NET_VAL, 0))) + (COALESCE(FA_RETURNS_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_RETURNS_NET_VAL_BCK;

--PROMO_RECEIPT_DISCOUNT_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_DISCOUNT_QTY TO PROMO_RECEIPT_DISCOUNT_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_DISCOUNT_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_DISCOUNT_QTY NUMBER(38,5)  COMMENT 'Promo Quantity Discount (Abverkauf)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_DISCOUNT_QTY = ((COALESCE(PV_DISCOUNT_QTY, 0)) + (COALESCE(NF_DISCOUNT_QTY, 0))) + (COALESCE(FA_DISCOUNT_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_DISCOUNT_QTY_BCK;

--PROMO_RECEIPT_DISCOUNT_SALES_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_DISCOUNT_SALES_QTY TO PROMO_RECEIPT_DISCOUNT_SALES_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_DISCOUNT_SALES_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_DISCOUNT_SALES_QTY NUMBER(38,5)  COMMENT 'Promo Sales_2 Quantity Discount (Abverkauf)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_DISCOUNT_SALES_QTY = ((COALESCE(PV_DISCOUNT_SALES_QTY, 0)) + (COALESCE(NF_DISCOUNT_SALES_QTY, 0))) + (COALESCE(FA_DISCOUNT_SALES_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_DISCOUNT_SALES_QTY_BCK;

--PROMO_RECEIPT_DISCOUNT_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_DISCOUNT_NET_VAL TO PROMO_RECEIPT_DISCOUNT_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_DISCOUNT_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_DISCOUNT_NET_VAL NUMBER(38,5)  COMMENT 'Promo Discount Sales_2 Amount Net in Local Currency';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_DISCOUNT_NET_VAL = ((COALESCE(PV_DISCOUNT_NET_VAL, 0)) + (COALESCE(NF_DISCOUNT_NET_VAL, 0))) + (COALESCE(FA_DISCOUNT_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_DISCOUNT_NET_VAL_BCK;

--PROMO_RECEIPT_TURNOVER_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_TURNOVER_QTY TO PROMO_RECEIPT_TURNOVER_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_TURNOVER_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_TURNOVER_QTY NUMBER(38,5)  COMMENT 'For PROMO-Items (NF FA + PV) on the Receipt Calcualted Quantity Sales_2 + Returns (adjusted)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_TURNOVER_QTY = (COALESCE(PROMO_RECEIPT_SALES_QTY, 0)) + (COALESCE(PROMO_RECEIPT_RETURNS_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_TURNOVER_QTY_BCK;

--PROMO_RECEIPT_TURNOVER_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN PROMO_RECEIPT_TURNOVER_NET_VAL TO PROMO_RECEIPT_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_TURNOVER_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD PROMO_RECEIPT_TURNOVER_NET_VAL NUMBER(38,5)  COMMENT 'For PROMO-Items (NF FA + PV) on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET PROMO_RECEIPT_TURNOVER_NET_VAL = (COALESCE(PROMO_RECEIPT_SALES_NET_VAL, 0)) + (COALESCE(PROMO_RECEIPT_RETURNS_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP PROMO_RECEIPT_TURNOVER_NET_VAL_BCK;

--NP_RECEIPT_SALES_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_SALES_QTY TO NP_RECEIPT_SALES_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_SALES_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_SALES_QTY NUMBER(38,5)  COMMENT 'NP Sales_2 Quantity (Abverkauf) per Bon';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_SALES_QTY = (COALESCE(TOTAL_RECEIPT_SALES_QTY, 0)) - (COALESCE(PROMO_RECEIPT_SALES_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_SALES_QTY_BCK;

--NP_RECEIPT_SALES_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_SALES_NET_VAL TO NP_RECEIPT_SALES_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_SALES_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_SALES_NET_VAL NUMBER(38,5)  COMMENT 'NP Sales_2 Amount Net in Local Currency';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_SALES_NET_VAL = (COALESCE(TOTAL_RECEIPT_SALES_NET_VAL, 0)) - (COALESCE(PROMO_RECEIPT_SALES_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_SALES_NET_VAL_BCK;

--NP_RECEIPT_RETURNS_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_RETURNS_QTY TO NP_RECEIPT_RETURNS_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_RETURNS_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_RETURNS_QTY NUMBER(38,5)  COMMENT 'Promo Sales_2 Quantity NP (Abverkauf)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_RETURNS_QTY = (COALESCE(TOTAL_RECEIPT_RETURNS_QTY, 0)) - (COALESCE(PROMO_RECEIPT_RETURNS_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_RETURNS_QTY_BCK;

--NP_RECEIPT_RETURNS_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_RETURNS_NET_VAL TO NP_RECEIPT_RETURNS_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_RETURNS_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_RETURNS_NET_VAL NUMBER(38,5)  COMMENT 'NP Returns Sales_2 Amount Net in Local Currency';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_RETURNS_NET_VAL = (COALESCE(TOTAL_RECEIPT_RETURNS_NET_VAL, 0)) - (COALESCE(PROMO_RECEIPT_RETURNS_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_RETURNS_NET_VAL_BCK;

--NP_RECEIPT_DISCOUNT_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_DISCOUNT_QTY TO NP_RECEIPT_DISCOUNT_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_DISCOUNT_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_DISCOUNT_QTY NUMBER(38,5)  COMMENT 'NP Quantity Discount (Abverkauf)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_DISCOUNT_QTY = (COALESCE(TOTAL_RECEIPT_DISCOUNT_QTY, 0)) - (COALESCE(PROMO_RECEIPT_DISCOUNT_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_DISCOUNT_QTY_BCK;

--NP_RECEIPT_DISCOUNT_SALES_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_DISCOUNT_SALES_QTY TO NP_RECEIPT_DISCOUNT_SALES_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_DISCOUNT_SALES_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_DISCOUNT_SALES_QTY NUMBER(38,5)  COMMENT 'NP Sales_2 Quantity Discount (Abverkauf)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_DISCOUNT_SALES_QTY = (COALESCE(TOTAL_RECEIPT_DISCOUNT_SALES_QTY, 0)) - (COALESCE(PROMO_RECEIPT_DISCOUNT_SALES_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_DISCOUNT_SALES_QTY_BCK;

--NP_RECEIPT_DISCOUNT_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_DISCOUNT_NET_VAL TO NP_RECEIPT_DISCOUNT_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_DISCOUNT_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_DISCOUNT_NET_VAL NUMBER(38,5)  COMMENT 'NP Discount Sales_2 Amount Net in Local Currency';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_DISCOUNT_NET_VAL = (COALESCE(TOTAL_RECEIPT_DISCOUNT_NET_VAL, 0)) - (COALESCE(PROMO_RECEIPT_DISCOUNT_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_DISCOUNT_NET_VAL_BCK;

--NP_RECEIPT_TURNOVER_QTY
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_TURNOVER_QTY TO NP_RECEIPT_TURNOVER_QTY_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_TURNOVER_QTY;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_TURNOVER_QTY NUMBER(38,5)  COMMENT 'For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Quantity Sales_2 + Returns (adjusted)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_TURNOVER_QTY = (COALESCE(NP_RECEIPT_SALES_QTY, 0)) + (COALESCE(NP_RECEIPT_RETURNS_QTY, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_TURNOVER_QTY_BCK;

--NP_RECEIPT_TURNOVER_NET_VAL
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 RENAME COLUMN NP_RECEIPT_TURNOVER_NET_VAL TO NP_RECEIPT_TURNOVER_NET_VAL_BCK;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_TURNOVER_NET_VAL;
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD NP_RECEIPT_TURNOVER_NET_VAL NUMBER(38,5)  COMMENT 'For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
--UPDATE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2
--SET NP_RECEIPT_TURNOVER_NET_VAL = (COALESCE(NP_RECEIPT_SALES_NET_VAL, 0)) + (COALESCE(NP_RECEIPT_RETURNS_NET_VAL, 0)) WHERE CLIENT_ID = 32;
--ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 DROP NP_RECEIPT_TURNOVER_NET_VAL_BCK;

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD CHERRY_PICKER_RECEIPT_FG            INTEGER NOT NULL 	DEFAULT 0                           			COMMENT 'Receipt have characteristic of Cherry Picker Buyer';

ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_SALES_QTY           NUMBER(38,5)	COMMENT 'Special Sales_2 Quantity (Abverkauf) per Bon';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_SALES_NET_VAL       NUMBER(38,5)	COMMENT 'Special Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_RETURNS_QTY         NUMBER(38,5)	COMMENT 'Promo Sales_2 Quantity Special (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_RETURNS_NET_VAL     NUMBER(38,5)	COMMENT 'Special Returns Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_DISCOUNT_QTY        NUMBER(38,5)	COMMENT 'Special Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_DISCOUNT_SALES_QTY  NUMBER(38,5)	COMMENT 'Special Sales_2 Quantity Discount (Abverkauf)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_DISCOUNT_NET_VAL    NUMBER(38,5)	COMMENT 'Special Discount Sales_2 Amount Net in Local Currency';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_TURNOVER_QTY		NUMBER(38,5)	COMMENT 'For none Special - on the Receipt Calcualted Quantity Sales_2 + Returns (adjusted)';
ALTER TABLE LDL.P_LEW_MART_PIT.T_F_RECEIPT_2 ADD SPECIAL_RECEIPT_TURNOVER_NET_VAL    NUMBER(38,5)	COMMENT 'For none Special - on the Receipt Calcualted Net Sales_2 + Returns (adjusted)';
*/


-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##
 -- # -------------------------------------------

-- # -------------------------------------------
 -- AKU 2022-01-20 adding additional date / Time info

-- Additional Date Month Week and Year
 -- Promotion Receipts
 -- # -------------------------------------------

-- AKU 2022-01-26 Added additional calculations

-- PV_TURNOVER_NET_VAL					NUMBER(38,5) 																	COMMENT 'For PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)',

-- For future use
 -- AKU 2022-01-26 Added additional calculations

-- DISTINCT_PROMO_DESIGNER_ORIG_ITEM_NR_CNT NUMERIC(38,0) 																COMMENT '[Future Use] Number of distinct items which are Promo Designer per Bon',

-- AKU 2022-01-27 Note only national currency's of the countries are used

-- PV_TURNOVER_QTY						NUMBER(38,5) 																	COMMENT 'For PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)',

-- LIDL_PLUS_FG						INTEGER NOT NULL	DEFAULT 0 										COMMENT '[Future Use] Lidl Plus Flag/Indicator',

-- # -------------------------------------------
 -- AKU 2022-01-26 Added additional calculations

-- AKU 2023-03-18 ## Added more LP / PD_2 WAWI Calculations ##

-- AKU 20220121 Moved Cherry Picker to RECEIPT_ITEM because KPI calc. rule changed

-- # -------------------------------------------
 -- AKU 20210802 Added
 -- Technical fields

-- AKU 2022-01-26 Added additional calculations
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_f_receipt_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales_2'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_2 surrogate key'),
receipt_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Surrogate Key of Receipt'),
adv_week_start_day_id INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Start Weekday Nbr of. Adv Week. Based on Country_2 Configuration. E.g. Switzerland (CH=4) StartDay ID of Adv. Week. 4 (Thursday)'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Adv.Week of the Receipt Date'),
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
wawi_pv_sales_qty BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Sales_2 Quantity (Abverkauf)'),
wawi_pv_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Sales_2 Amount Net in Local Currency'),
wawi_pv_returns_qty BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Sales_2 Quantity Returns (Abverkauf)'),
wawi_pv_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Returns Sales_2 Amount Net in Local Currency'),
wawi_pv_discount_qty BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Quantity Discount (Abverkauf)'),
wawi_pv_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Sales_2 Quantity Discount (Abverkauf)'),
wawi_pv_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='WAWI PV Discount Sales_2 Amount Net in Local Currency'),
wawi_pv_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='WAWI PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'),
wawi_pv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='WAWI PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
lp_pv_sales_qty BIGNUMERIC(38,5) OPTIONS(description='LP PV Sales_2 Quantity (Abverkauf)'),
lp_pv_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='LP PV Sales_2 Amount Net in Local Currency'),
lp_pv_returns_qty BIGNUMERIC(38,5) OPTIONS(description='LP PV Sales_2 Quantity Returns (Abverkauf)'),
lp_pv_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='LP PV Returns Sales_2 Amount Net in Local Currency'),
lp_pv_discount_qty BIGNUMERIC(38,5) OPTIONS(description='LP PV Quantity Discount (Abverkauf)'),
lp_pv_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='LP PV Sales_2 Quantity Discount (Abverkauf)'),
lp_pv_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='LP PV Discount Sales_2 Amount Net in Local Currency'),
lp_pv_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='LP PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'),
lp_pv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='LP PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
npps_pv_sales_qty BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Sales_2 Quantity (Abverkauf)'),
npps_pv_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Sales_2 Amount Net in Local Currency'),
npps_pv_returns_qty BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Sales_2 Quantity Returns (Abverkauf)'),
npps_pv_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Returns Sales_2 Amount Net in Local Currency'),
npps_pv_discount_qty BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Quantity Discount (Abverkauf)'),
npps_pv_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Sales_2 Quantity Discount (Abverkauf)'),
npps_pv_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='NPPS PV Discount Sales_2 Amount Net in Local Currency'),
npps_pv_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='NPPS PV-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'),
npps_pv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='NPPS PV-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
nf_sales_qty BIGNUMERIC(38,5) OPTIONS(description='NF Sales_2 Quantity (Abverkauf)'),
nf_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='NF Sales_2 Amount Net in Local Currency'),
nf_returns_qty BIGNUMERIC(38,5) OPTIONS(description='NF Sales_2 Quantity Returns (Abverkauf)'),
nf_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='NF Returns Sales_2 Amount Net in Local Currency'),
nf_discount_qty BIGNUMERIC(38,5) OPTIONS(description='NF Sales_2 Quantity Discount (Abverkauf)'),
nf_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='NF Discount Sales_2 Quantity without Returned Goods'),
nf_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='NF Discount Sales_2 Amount Net in Local Currency'),
nf_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[VC] For NF-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'),
nf_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[VC] For NF-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
fa_sales_qty BIGNUMERIC(38,5) OPTIONS(description='FA Sales_2 Quantity (Abverkauf)'),
fa_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='FA Sales_2 Amount Net in Local Currency'),
fa_returns_qty BIGNUMERIC(38,5) OPTIONS(description='FA Sales_2 Quantity Returns (Abverkauf)'),
fa_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='FA Returns Sales_2 Amount Net in Local Currency'),
fa_discount_qty BIGNUMERIC(38,5) OPTIONS(description='FA Sales_2 Quantity Discount (Abverkauf)'),
fa_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='FA Discount Sales_2 Quantity without Returned Goods'),
fa_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='FA Discount Sales_2 Amount Net in Local Currency'),
fa_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[VC] For FA-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'),
fa_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[VC] For FA-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
total_receipt_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Total Sales_2 Quantity (Abverkauf) per Bon'),
total_receipt_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Total Sales_2 Amount Net in Local Currency'),
total_receipt_returns_qty BIGNUMERIC(38,5) OPTIONS(description='Total Sales_2 Quantity Returns (Abverkauf)'),
total_receipt_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='Total Returns Sales_2 Amount Net in Local Currency'),
total_receipt_discount_qty BIGNUMERIC(38,5) OPTIONS(description='Total Sales_2 Quantity Discount (Abverkauf)'),
total_receipt_discount_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='Total Discount Sales_2 Quantity without Returned Goods'),
total_receipt_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Total Discount Sales_2 Amount Net in Local Currency'),
total_receipt_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='[VC] For All-Items on the Receipt Calcualted Quantity  Sales_2 + Returns (adjusted)'),
total_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='[VC] For All-Items on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
promo_receipt_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Promo Sales_2 Quantity (Abverkauf) per Bon'),
promo_receipt_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='Promo Sales_2 Amount Net in Local Currency'),
promo_receipt_returns_qty BIGNUMERIC(38,5) OPTIONS(description='Promo Sales_2 Quantity Returns (Abverkauf)'),
promo_receipt_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='Promo Returns Sales_2 Amount Net in Local Currency'),
promo_receipt_discount_qty BIGNUMERIC(38,5) OPTIONS(description='Promo Quantity Discount (Abverkauf)'),
promo_receipt_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Promo Sales_2 Quantity Discount (Abverkauf)'),
promo_receipt_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='Promo Discount Sales_2 Amount Net in Local Currency'),
promo_receipt_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='For PROMO-Items (NF FA + PV) on the Receipt Calcualted Quantity Sales_2 + Returns (adjusted)'),
promo_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For PROMO-Items (NF FA + PV) on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
np_receipt_sales_qty BIGNUMERIC(38,5) OPTIONS(description='NP Sales_2 Quantity (Abverkauf) per Bon'),
np_receipt_sales_net_val BIGNUMERIC(38,5) OPTIONS(description='NP Sales_2 Amount Net in Local Currency'),
np_receipt_returns_qty BIGNUMERIC(38,5) OPTIONS(description='Promo Sales_2 Quantity NP (Abverkauf)'),
np_receipt_returns_net_val BIGNUMERIC(38,5) OPTIONS(description='NP Returns Sales_2 Amount Net in Local Currency'),
np_receipt_discount_qty BIGNUMERIC(38,5) OPTIONS(description='NP Quantity Discount (Abverkauf)'),
np_receipt_discount_sales_qty BIGNUMERIC(38,5) OPTIONS(description='NP Sales_2 Quantity Discount (Abverkauf)'),
np_receipt_discount_net_val BIGNUMERIC(38,5) OPTIONS(description='NP Discount Sales_2 Amount Net in Local Currency'),
np_receipt_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Quantity Sales_2 + Returns (adjusted)'),
np_receipt_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Net Sales_2 + Returns (adjusted)'),
distinct_total_orig_item_nr_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of distinct items OVERall per Bon'),
distinct_return_orig_item_nr_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of distinct items which was returned per Bon'),
distinct_discount_orig_item_nr_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of distinct items which was discounted per Bon'),
distinct_nf_orig_item_nr_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of distinct items which are NF per Bon'),
distinct_fa_orig_item_nr_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of distinct items which FA per Bon'),
distinct_np_orig_item_nr_cnt BIGNUMERIC(38,0)
OPTIONS(description='[VC] Number of distinct items which are Normalsortiment per Bon'),
cherry_picker_receipt_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Receipt have characteristic of Cherry Picker Buyer'),
heavy_buyer_receipt_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Receipt have characteristic of Heavy Buyer'),
exclusive_buyer_receipt_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Receipt have characteristic of Exclusive Buyer'),
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
PRIMARY KEY (client_id, day_dt, store_sid, receipt_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Intermediate Fact Table on receipt (Bon)');