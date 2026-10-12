/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_PSNF_STORE_ADV_PERIOD_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0		2023-07-25 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM CLUSTER BY ( CLIENT_ID)(
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Client ID e.g, AT:==1',

	COUNTRY_ISO_CD						VARCHAR(3) 																			COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR						VARCHAR 																			COMMENT 'Country Name',

	ITEM_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Item Variant (Case Size)',
	ORIG_ITEM_NR						INTEGER																				COMMENT 'Item NaN (National Artikel Nummer) Link to Item History',

	ADV_PERIOD_START_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'Start day of the extended period',
	ADV_PERIOD_END_DAY_DT				DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'End day of the extended period',

	REPORTING_ADV_PERIOD_START_DAY_DT	DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD')				COMMENT 'Start day of Advertisement Period',
	REPORTING_ADV_PERIOD_END_DAY_DT		DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 			COMMENT 'End day of Advertisement Period',
	
	OVERLAP_PERIOD_FG									SMALLINT	DEFAULT 0 												COMMENT 'If periods overlap',
	CUT_PERIOD_FG										SMALLINT	DEFAULT 0 												COMMENT 'If periods overlap and  start date difference is greater than 7 days and which have an overlap',


	STORE_SID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Unique key Region surrogate key',
	STORE_NAME							VARCHAR 																			COMMENT 'Store Name',
	ORIG_STORE_NR						INTEGER		 																		COMMENT 'Orig Store NUMBER',

	-- FAKTEN / MEASURES / KPIs
	DELIVERED_QTY						NUMBER(38,5) 																		COMMENT 'Quantity of items to be promoted ( stock on the day before the extended period starts and delivery to the store during the period). ',
	-- Technical fields
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID,STORE_SID, ORIG_ITEM_NR, REPORTING_ADV_PERIOD_START_DAY_DT)
)	COMMENT='Information about promotional periods in stores'
;