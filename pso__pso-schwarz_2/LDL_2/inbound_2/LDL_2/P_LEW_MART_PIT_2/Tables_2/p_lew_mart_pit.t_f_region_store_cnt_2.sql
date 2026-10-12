/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for F_REGION_STORE_CNT
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Basis Fact Table Region_2 Store Counts
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-24 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0  2022-11-23 Nikolai Toknov	Reworked the structure
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
ADV_WEEK_MSTR_ID
*/

CREATE TABLE P_LEW_MART_PIT.T_F_REGION_STORE_CNT_2 CLUSTER BY (CLIENT_ID, ADV_WEEK_ID)(
	CLIENT_ID					INTEGER				NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g',
		
	COUNTRY_ISO_CD				VARCHAR(3) 																	COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR				VARCHAR 																	COMMENT 'Country_2 Name',
		
--	DAY_DT						DATE				NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD')	COMMENT 'Day of Sales_2',
--	WEEK_ID						INTEGER				NOT NULL	DEFAULT 888853 								COMMENT 'Week (based on ISO) of Sales. Added to have better join options in aggregation jobs',
--	MONTH_ID					INTEGER				NOT NULL	DEFAULT 888812 								COMMENT 'Month of Sales_2',
--	YEAR_ID						INTEGER				NOT NULL	DEFAULT 8888 								COMMENT 'Year (based on ISO) of Sales_2',

	-- AKU 2022-01-24 possible add cal. date flags like 	
--	MONTH_END_FG				SMALLINT						DEFAULT 0,
--	MONTH_START_FG				SMALLINT						DEFAULT 0,
	
	ADV_WEEK_ID					INTEGER				NOT NULL	DEFAULT 888853 								COMMENT 'Advertising Week',
	
	WAREHOUSE_SID				INTEGER				NOT NULL 	DEFAULT -1 									COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME				VARCHAR 																	COMMENT 'Warehouse Name',
	ORIG_WH_NR					INTEGER		 																COMMENT 'Original Wahrehouse Number  / code from Wawi',
		
	A_LEVEL_ID					INTEGER				NOT NULL 	DEFAULT -1 									COMMENT 'Aggregation Level of the KPI',
				
    -- FAKTEN / MEASURES / KPIs 				
	TOTAL_STORE_CNT				NUMBER(38,0)		NOT NULL 	DEFAULT 0 									COMMENT 'Store Count of this Day (only open Stores which have sales_2 more than the limits on RECEIPT_CNT and TURNOVER_NET_VAL)',
	--PV_STORE_CNT				NUMBER(38,0)		NOT NULL 	DEFAULT 0 									COMMENT 'Store Count of this Day which have sold at least one PV Item_2 ',
	--ADV_WEEK_STORE_CNT		NUMBER(38,0)		NOT NULL 	DEFAULT 0 									COMMENT 'Count of Store which have sold at least one item_2 in the week',
	--MONTH_STORE_CNT			NUMBER(38,0)		NOT NULL 	DEFAULT 0 									COMMENT 'Store Count of the Last day of month assigned of the day which have sold at least one Item_2',
	--PV_MONTH_STORE_CNT		NUMBER(38,0)		NOT NULL 	DEFAULT 0 									COMMENT 'Store Count of the Last day of month assigned of the day which have sold at least one PV Item_2',
					
    -- Technical fields					
	REJECT_REASON_ID			INTEGER				NOT NULL 	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG					SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID			INTEGER				NOT NULL 	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG					SMALLINT			NOT NULL 	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 															COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER				NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_WEEK_ID, DELETED_FG)
)	COMMENT='Basis Fact Table Region_2 Store Counts'
;
