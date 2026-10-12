/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_STORE_DAY_ITEM_ADV_LP_PV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for sales 
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
USE SCHEMA 		P_LEW_MART_PIT;
*/

CREATE TABLE P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_ADV_LP_PV CLUSTER BY ( CLIENT_ID, DAY_DT )(
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Client ID e.g, AT:==1',

	COUNTRY_ISO_CD						VARCHAR(3) 																			COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR						VARCHAR 																			COMMENT 'Country Name',

	ITEM_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Item Variant (Case Size)',
	ORIG_ITEM_NR						INTEGER																				COMMENT 'Item NaN (National Artikel Nummer) Link to Item History',
--	ORIG_ITEM_MSTR_NR					INTEGER						DEFAULT -1 												COMMENT 'Item NaN (National Artikel Nummer) Link - Frontend Join',
						
	SUB_ITEM_GRP_SID					INTEGER						DEFAULT -1 												COMMENT 'Additional Link to UWG Default values in case of missing UWGs',
	SUB_ITEM_GRP_SRC_CD					VARCHAR																				COMMENT 'UWG Src CD',
	ITEM_GRP_INT_SID					INTEGER						DEFAULT -1 												COMMENT 'Sid for item international group. (WGI)',
	SUB_ITEM_GRP_INT_DESCR				VARCHAR																				COMMENT 'Item sub group description (international).',
	ITEM_GRP_INT_SRC_CD					VARCHAR                                                                             COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_DESCR					VARCHAR                                                                             COMMENT 'International group description (local).',
	ITEM_NAME							VARCHAR                                                                             COMMENT '(short) item name in local LANGUAGE',
	
	
	DAY_DT								DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'Day of Sales',
	WEEK_ID								INTEGER			NOT NULL	DEFAULT 888853 											COMMENT 'Week (based on ISO) of Sales. Added to have better join options in aggregation process',
	MONTH_ID							INTEGER			NOT NULL	DEFAULT 888812 											COMMENT 'Month of Sales',
	YEAR_ID								INTEGER			NOT NULL	DEFAULT 8888 											COMMENT 'Year (based on ISO) of Sales',
				
	ADV_WEEK_ID							INTEGER			NOT NULL	DEFAULT 888853 											COMMENT 'Advertising Week',
	ADV_PERIOD_ID						INTEGER			NOT NULL															COMMENT 'Advertising Period WaWi-PV',

	ADV_PERIOD_START_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'Start day of Advertisement Period',
	ADV_PERIOD_END_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'End day of Advertisement Period',
	ADV_PERIOD_LENGTH_IN_DAYS  			INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Length Advertisement Period in Days',

	REPORTING_ADV_PERIOD_START_DAY_DT 	DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'Start day of Advertisement Period',
	REPORTING_ADV_PERIOD_END_DAY_DT 	DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'End day of Advertisement Period',
--	REPORTING_ADV_PERIOD_FG 			INTEGER 					DEFAULT 1                                  				COMMENT 'Indicator [0,1] If day between periods start / end then 1',

	STORE_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Unique key Region surrogate key',
	STORE_NAME							VARCHAR 																			COMMENT 'Store Name',
	ORIG_STORE_NR						INTEGER		 																		COMMENT 'Orig Store NUMBER',
			
	WAREHOUSE_SID						INTEGER						DEFAULT -1 												COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME						VARCHAR 																			COMMENT 'Warehouse Name',
	ORIG_WH_NR							INTEGER		 																		COMMENT 'Original Wahrehouse NUMBER  / code from Wawi',

	-- AKU 2022-01-27 Note only national currency's of the countries are used
	CURR_SID							INTEGER						DEFAULT -1 												COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country',
	CURR_CD								VARCHAR 																			COMMENT 'Currency Code',
								
	THEME_GRP_NAT_SID					INTEGER																				COMMENT 'FK to Theme Group NAT',
	THEME_GRP_INT_SID					INTEGER																				COMMENT 'FK to Theme Group INT',

	THEME_GRP_NAT_CAT_SID				INTEGER		 																		COMMENT 'FK to Theme Group NAT Category',

						
	ACTION_TYPE_ID						INTEGER						DEFAULT -1 												COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS',
								
	A_LEVEL_ID							INTEGER						DEFAULT -1 												COMMENT 'Aggregation Level of the KPI',

	-- FAKTEN / MEASURES / KPIs
	SALES_QTY							NUMBER(38,5) 																		COMMENT 'Sales Quantity Abverkauf',
	RETURN_QTY							NUMBER(38,5) 																		COMMENT 'Sales Quantity Returned Goods',
	DISCOUNT_QTY						NUMBER(38,5) 																		COMMENT 'Discounted Quantity of Sales Goods e.g. 1plus1',
	SALES_NET_VAL						NUMBER(38,5) 																		COMMENT 'Sales Amount Net in Local Currency',
	RETURN_NET_VAL						NUMBER(38,5) 																		COMMENT 'Sales Amount Returned items in Local Currency',
	DISCOUNT_NET_VAL					NUMBER(38,5) 																		COMMENT 'Sales Amount Discounted items in Local Currency',
						
	TURNOVER_QTY						NUMBER(38,5) 																		COMMENT 'Calcualted Quantity  Sales + Returns (adjusted)',
	TURNOVER_SALES_NET_VAL				NUMBER(38,5) 																		COMMENT 'Calcualted Net Value Sales + Returns (adjusted)',
	TURNOVER_SALES_GROSS_VAL			NUMBER(38,5) 																		COMMENT 'Calcualted Gross Value Sales + Returns (adjusted)',
			
	VAT_FACTOR							NUMBER(38,5) 				DEFAULT 0 												COMMENT 'Tax Vat Factor e.g. 0,2 for 20%',
						
	TOTAL_RECEIPT_TURNOVER_NET_VAL		NUMBER(38,5)																		COMMENT 'For All-Items on the Receipt Calcualted Net Sales + Returns (adjusted)',
	PROMO_RECEIPT_TURNOVER_NET_VAL		NUMBER(38,5)																		COMMENT 'For PROMO-Items (NF FA + PV) on the Receipt Calcualted Net Sales + Returns (adjusted)',
	NP_RECEIPT_TURNOVER_NET_VAL			NUMBER(38,5)																		COMMENT 'For none PROMO-Items (NF FA + PV) - Normalpreis - on the Receipt Calcualted Net Sales + Returns (adjusted)',

	RECEIPT_CNT							NUMBER(38,0)																		COMMENT 'NBR_OF_BONS',
	
	PRICE_OLD_GROSS						NUMBER(38,5)																		COMMENT 'VK-Alt Preis (Brutto)',
	PRICE_NEW_GROSS                     NUMBER(38,5)																		COMMENT 'VK-Neu Preis (Brutto), WaWi-PV',
	ITEM_SAME_PRICE						SMALLINT					DEFAULT -1 												COMMENT 'Flag /Indicator Old and New Price are the same',

	SALES_PRICE_GROSS					NUMBER(38,5) 																		COMMENT 'Item Variant Sales Price Gross New == reduced price',

	CHEAPER_IN_PCT						NUMBER(38,5) 																		COMMENT 'Billiger in  %',
	
	PV_CALCULATED_NET_VAL				NUMBER(38,5) 																		COMMENT 'Calculated PV ValuePV-Value if Action type = PV (Price Old – Price New)* sales_qty',


	ITEM_UNIT_PRICE						NUMBER(38,5)																		COMMENT 'Item Unit Price needed for PV Calculation algortithm',
	
	-- AKU 2022-01-24 Adding some baseline facts 
	BASE_RECEIPT_CNT					NUMBER(38,5) 																		COMMENT 'Bons Baseline (Anz.): Receipts count (last 6 weeks lfl)',
	BASE_RESTBON_TURNOVER_NET_VAL		NUMBER(38,5) 																		COMMENT 'Ø-Restbon Baseline: Sales net val minus returns of Restbon (last 6 weeks lfl)',
	BASE_TURNOVER_NET_VAL				NUMBER(38,5) 																		COMMENT 'Umsatz Baseline: Sales net val minus returns (last 6 weeks lfl)',
	BASE_TURNOVER_QTY					NUMBER(38,5) 																		COMMENT 'Abverkauf Baseline (Stk/kg): Sales qty minus returns (last 6 weeks lfl)',
	BASE_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 																		COMMENT 'Abverkaufsertrag Baseline, calculated from sales net val minus returns (last 6 weeks lfl)',

	-- AKU 2022-01-19 Possible preaggregation of KPIs based on timeframes of KPI sheet
	-- need to be reconsidered! only an example
	-- Stock from previous 5 days plus Delivery Qty from 5 days before and 13 days after
	-- Real Delivered Quantity
	DELIVERED_QTY						NUMBER(38,5)																		COMMENT 'Quantity of items to be promoted ( stock on the day before the extended period starts and delivery to the store during the period).',

	-- Buying Preis Effective - Information from WH based on CNTL table of Buying price ranges
	ITEM_BUYING_PRICE_EFF				NUMBER(38,5) 																		COMMENT 'Einkaufspreis (EK) Buying Price calcualted based on the CNTL Table BuyingPrice Range;. Distributed equaly via the item_sid join via orig_item_nr',
	-- debug
	PV_CALCULATED_LP_ONLY_NET_VAL		NUMBER(38,5) 																		COMMENT 'Calculated PV for LP only (w/o impact from WAWI-PV)',
	PV_CALCULATED_WAWI_UNDER_LP_NET_VAL	NUMBER(38,5) 																		COMMENT 'Calculated WAWI-PV under LP (In case the periods overlap)',

    NP_ITEM_UNIT_PRICE_GROSS			NUMBER(38,5) ,
    NP_ITEM_UNIT_PRICE_NET				NUMBER(38,5) ,
    NP_PRICEGROUP_DESC					VARCHAR      ,
    NP_PRICEGROUP_ID					INTEGER		 ,
    NP_PRICEGROUP_PRIORITY 				INTEGER		 ,

    PV_ITEM_UNIT_PRICE_GROSS			NUMBER(38,5) ,
    PV_ITEM_UNIT_PRICE_NET				NUMBER(38,5) ,
    PV_PRICEGROUP_DESC					VARCHAR      ,
    PV_PRICEGROUP_ID					INTEGER		 ,
    PV_PRICEGROUP_PRIORITY 				INTEGER		 ,


	-- Technical fields
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Basis Fact Table on Store Day Item (LP PV)'
;