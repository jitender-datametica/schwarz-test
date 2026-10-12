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
#  1.12		2023-03-16 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  1.13  	2023-09-05 Andreas Kurz		Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
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

CREATE TABLE P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_1 CLUSTER BY ( CLIENT_ID, DAY_DT )(
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Client ID e.g, AT:==1',

	COUNTRY_ISO_CD						VARCHAR(3) 																			COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR						VARCHAR 																			COMMENT 'Country_1 Name',

	ITEM_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Item_1 Variant (Case Size)',
	ORIG_ITEM_NR						INTEGER																				COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History',
--	ORIG_ITEM_MSTR_NR					INTEGER						DEFAULT -1 												COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link - Frontend Join',
						
	SUB_ITEM_GRP_SID					INTEGER						DEFAULT -1 												COMMENT 'Additional Link to UWG Default values in case of missing UWGs',
	ITEM_GRP_INT_SID					INTEGER						DEFAULT -1 												COMMENT 'Additional Link to WGI Default values in case of missing WGI',
		
	DAY_DT								DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Day of Sales_1',
	WEEK_ID								INTEGER			NOT NULL	DEFAULT 888853 											COMMENT 'Week (based on ISO) of Sales. Added to have better join options in aggregation process',
	MONTH_ID							INTEGER			NOT NULL	DEFAULT 888812 											COMMENT 'Month of Sales_1',
	YEAR_ID								INTEGER			NOT NULL	DEFAULT 8888 											COMMENT 'Year (based on ISO) of Sales_1',
				
	ADV_WEEK_ID							INTEGER			NOT NULL	DEFAULT 888853 											COMMENT 'Advertising Week',
	ADV_PERIOD_ID						INTEGER			NOT NULL															COMMENT 'Advertising Period',
--	ADV_WEEK_MSTR_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Advertising Week - Frontend Join',
--	ADV_PERIOD_MSTR_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Advertising Period - Frontend Join',

	ADV_PERIOD_START_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Start day of Advertisement Period',
	ADV_PERIOD_END_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'End day of Advertisement Period',

	REPORTING_ADV_PERIOD_START_DAY_DT	DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD'),
	REPORTING_ADV_PERIOD_END_DAY_DT		DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD'),
--	REPORTING_ADV_PERIOD_FG				SMALLINT	 AS (
--											IFF((DAY_DT >= REPORTING_ADV_PERIOD_START_DAY_DT) AND (DAY_DT <= REPORTING_ADV_PERIOD_END_DAY_DT), 1, 0)
--														),

	STORE_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Unique key Region_1 surrogate key',
	STORE_NAME							VARCHAR 																			COMMENT 'Store Name',
	ORIG_STORE_NR						INTEGER		 																		COMMENT 'Orig Store NUMBER',
			
	WAREHOUSE_SID						INTEGER						DEFAULT -1 												COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME						VARCHAR 																			COMMENT 'Warehouse Name',
	ORIG_WH_NR							INTEGER		 																		COMMENT 'Original Wahrehouse NUMBER  / code from Wawi',

	-- AKU 2022-01-27 Note only national currency's of the countries are used
	CURR_SID							INTEGER						DEFAULT -1 												COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country_1',
	CURR_CD								VARCHAR 																			COMMENT 'Currency Code',
								
--	THEME_NAT_SID						INTEGER																				COMMENT 'Unique system ID, sid, for the theme NAT.',
--	THEME_NAT_MSTR_SID					INTEGER																				COMMENT '[VC] MSTR surrogate Key',
	THEME_GRP_NAT_SID					INTEGER																				COMMENT 'FK to Theme Group NAT',
--	THEME_GRP_NAT_MSTR_SID				INTEGER																				COMMENT '[VC] MSTR surrogate Key : Theme Group NAT',
										
--	THEME_INT_SID						INTEGER																				COMMENT 'Unique system ID, sid, for the theme INT.',
--	THEME_INT_MSTR_SID					INTEGER																				COMMENT '[VC] MSTR surrogate Key',
	THEME_GRP_INT_SID					INTEGER																				COMMENT 'FK to Theme Group INT',
--	THEME_GRP_INT_MSTR_SID				INTEGER																				COMMENT '[VC] MSTR surrogate Key : Theme Group INT',

	THEME_GRP_NAT_CAT_SID				INTEGER		 				DEFAULT -1000											COMMENT 'FK to Theme Group NAT Category',
--	THEME_GRP_NAT_CAT_MSTR_SID			INTEGER		 																		COMMENT 'MSTR surrogate Key : Theme Group NAT Category',

						
	ACTION_TYPE_ID						INTEGER						DEFAULT -1 												COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV',
	ITEM_FA_FG							SMALLINT					DEFAULT 0,
	ITEM_NF_FG							SMALLINT					DEFAULT 0,
	ITEM_PV_FG							SMALLINT					DEFAULT 0,
	ITEM_NP_FG							SMALLINT					DEFAULT 0,
								
	A_LEVEL_ID							INTEGER						DEFAULT -1 												COMMENT 'Aggregation Level of the KPI',

	-- FAKTEN / MEASURES / KPIs
	SALES_QTY							NUMBER(38,5) 																		COMMENT 'Sales_1 Quantity Abverkauf',
	RETURN_QTY							NUMBER(38,5) 																		COMMENT 'Sales_1 Quantity Returned Goods',
	DISCOUNT_QTY						NUMBER(38,5) 																		COMMENT 'Discounted Quantity of Sales_1 Goods e.g. 1plus1',
	SALES_NET_VAL						NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Net in Local Currency',
	RETURN_NET_VAL						NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Returned items in Local Currency',
	DISCOUNT_NET_VAL					NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Discounted items in Local Currency',
						
	TURNOVER_QTY						NUMBER(38,5) 																		COMMENT 'Calcualted Quantity  Sales_1 + Returns (adjusted)',
	TURNOVER_SALES_NET_VAL				NUMBER(38,5) 																		COMMENT 'Calcualted Net Value Sales_1 + Returns (adjusted)',
						
	VAT_FACTOR							NUMBER(38,5) 				DEFAULT 0 												COMMENT 'Tax Vat Factor e.g. 0,2 for 20%',
						
	EFF_PRICE_GROSS						NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Gross New == reduced price',
	EFF_PRICE_NET						NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Net New == reduced price',
								
	SALES_PRICE_GROSS					NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Gross New == reduced price',
	SALES_PRICE_NET						NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Net New == reduced price',

	-- Add 2022.05.19
	TOTAL_RECEIPT_TURNOVER_NET_VAL		NUMBER(38,5),
	PROMO_RECEIPT_TURNOVER_NET_VAL		NUMBER(38,5),
	NP_RECEIPT_TURNOVER_NET_VAL			NUMBER(38,5),

	-- Add 2022.04.21
	RECEIPT_CNT							NUMBER(38,0),

	-- AKU 2022-01-24 for future use	
	SALES_DEFAULT_PRICE_GROSS			NUMBER(38,5) 																		COMMENT 'Future Use: Item_1 Variant Sales_1 Price Gross Default price relevant for PV',
	SALES_DEFAULT_PRICE_NET				NUMBER(38,5) 																		COMMENT 'Future Use : Item_1 Variant Sales_1 Price Net Default price relevant for PV',

	ITEM_SAME_PRICE_FG					SMALLINT					DEFAULT -1 												COMMENT 'Flag /Indicator Old and New Price are the same',

	-- AKU 2022-01-24 for future use SFO (PV)
	PRICE_DROP_FIRST_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Future Use: PV Optional: First Day of Price  Drop Detected',
	PRICE_DROP_LAST_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Future Use: PV Optional: Last Day of Price  Drop Detected',

	CHEAPER_IN_PCT						NUMBER(38,5) 																		COMMENT 'Billiger in  %',
								
	PV_CALCULATED_VAL					NUMBER(38,5) 																		COMMENT 'Calculated PV ValuePV-Value if Action type = PV (Price Old – Price New)* sales_qty',

	-- AKU 2022-01-24 for future use SFO (PV)
	PV_SFO_VAL							NUMBER(38,5) 																		COMMENT 'PV-Value from SFO ',

	-- AKU 2022-01-24 Adding some baseline facts 
	BASE_RECEIPT_CNT					NUMBER(38,5) 																		COMMENT 'Bons Baseline (Anz.): Receipts count (last 6 weeks lfl)',
	BASE_RESTBON_TURNOVER_NET_VAL		NUMBER(38,5) 																		COMMENT 'Ø-Restbon Baseline: Sales_1 net val minus returns of Restbon (last 6 weeks lfl)',
	BASE_TURNOVER_NET_VAL				NUMBER(38,5) 																		COMMENT 'Umsatz Baseline: Sales_1 net val minus returns (last 6 weeks lfl)',
	BASE_TURNOVER_QTY					NUMBER(38,5) 																		COMMENT 'Abverkauf Baseline (Stk/kg): Sales_1 qty minus returns (last 6 weeks lfl)',
	BASE_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 																		COMMENT 'Abverkaufsertrag Baseline, calculated from sales_1 net val minus returns (last 6 weeks lfl)',

	-- AKU 2022-01-19 Possible preaggregation of KPIs based on timeframes of KPI sheet
	-- need to be reconsidered! only an example
	-- Stock from previous 5 days plus Delivery Qty from 5 days before and 13 days after
	-- Real Delivered Quantity
	DELIVERED_QTY						NUMBER(38,5),

	-- Buying Preis Effective - Information from WH based on CNTL table of Buying price ranges
	ITEM_BUYING_PRICE_EFF				NUMBER(38,5) 																		COMMENT 'Einkaufspreis (EK) Buying Price calcualted based on the CNTL Table BuyingPrice Range;. Distributed equaly via the item_sid join via orig_item_nr',

	-- Technical fields
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Basis Fact Table on Store Day Item_1'
;