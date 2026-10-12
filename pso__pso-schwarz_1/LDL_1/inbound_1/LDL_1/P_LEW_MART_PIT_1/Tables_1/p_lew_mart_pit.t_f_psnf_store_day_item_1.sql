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
CREATE TABLE P_LEW_MART_PIT.T_F_PSNF_STORE_DAY_ITEM_1 CLUSTER BY ( CLIENT_ID, DAY_DT )(
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Client ID e.g, AT:==1',

	COUNTRY_ISO_CD						VARCHAR(3) 																			COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR						VARCHAR 																			COMMENT 'Country_1 Name',

	ITEM_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Item_1 Variant (Case Size)',
	ORIG_ITEM_NR						INTEGER																				COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History',

		
	DAY_DT								DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Day of Sales_1',

	ADV_PERIOD_START_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'Start day of the extended period',
	ADV_PERIOD_END_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'End day of the extended period',

	REPORTING_ADV_PERIOD_START_DAY_DT	DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD')				COMMENT 'Start day of Advertisement Period',
	REPORTING_ADV_PERIOD_END_DAY_DT		DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') 			COMMENT 'End day of Advertisement Period',
	OVERLAP_PERIOD_FG									SMALLINT	DEFAULT 0 												COMMENT 'If periods overlap',
	CUT_PERIOD_FG										SMALLINT	DEFAULT 0 												COMMENT 'If periods overlap and  start date difference is greater than 7 days and which have an overlap',


	STORE_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Unique key Region_1 surrogate key',
	STORE_NAME							VARCHAR 																			COMMENT 'Store Name',
	ORIG_STORE_NR						INTEGER		 																		COMMENT 'Orig Store NUMBER',

	-- AKU 2022-01-27 Note only national currency's of the countries are used
	CURR_SID							INTEGER						DEFAULT -1 												COMMENT '[FK] Unique Currency SID based Local Currency of Lidl Country_1',
	CURR_CD								VARCHAR 																			COMMENT 'Currency Code',								

	-- FAKTEN / MEASURES / KPIs
	SALES_QTY							NUMBER(38,5) 																		COMMENT 'Sales_1 Quantity Abverkauf',
	RETURN_QTY							NUMBER(38,5) 																		COMMENT 'Sales_1 Quantity Returned Goods',
	DISCOUNT_QTY						NUMBER(38,5) 																		COMMENT 'Discounted Quantity of Sales_1 Goods e.g. 1plus1',
	SALES_NET_VAL						NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Net in Local Currency',
	SALES_GROSS_VAL						NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Gross in Local Currency',
	RETURN_NET_VAL						NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Returned items Net in Local Currency',
	RETURN_GROSS_VAL					NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Returned items Gross in Local Currency',
	DISCOUNT_NET_VAL					NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Discounted items Net in Local Currency',
	DISCOUNT_GROSS_VAL					NUMBER(38,5) 																		COMMENT 'Sales_1 Amount Discounted items Gross in Local Currency',
						
	TURNOVER_QTY						NUMBER(38,5) 																		COMMENT 'Calcualted Quantity  Sales_1 + Returns (adjusted)',
	TURNOVER_SALES_NET_VAL				NUMBER(38,5) 																		COMMENT 'Calcualted Net Value Sales_1 + Returns (adjusted)',
	TURNOVER_SALES_GROSS_VAL			NUMBER(38,5) 																		COMMENT 'Calcualted Gross Value Sales_1 + Returns (adjusted)',
		
	VAT_FACTOR							NUMBER(38,5) 				DEFAULT 0 												COMMENT 'Tax Vat Factor e.g. 0,2 for 20%',
						
	EFF_PRICE_GROSS						NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Gross New == reduced price',
	EFF_PRICE_NET						NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Net New == reduced price',
								
	SALES_PRICE_GROSS					NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Gross New == reduced price',
	SALES_PRICE_NET						NUMBER(38,5) 																		COMMENT 'Item_1 Variant Sales_1 Price Net New == reduced price',

	RECEIPT_CNT							NUMBER(38,0),

--	DELIVERED_QTY						NUMBER(38,5),

	-- Technical fields
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ORIG_ITEM_NR, DELETED_FG)
)	COMMENT='Basis Fact Table on Store Day Item_1'
;