create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASHIER_RANKING_BY_FRAUD_SCENARIO_2 (
	SALES_COMPANY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the sales_2 company (VGES) to which this store is related.',
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related cash register event happened.',
	CASHIER_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
	RANK_SEQ NUMBER(38,0) NOT NULL COMMENT 'This column will contain a rank number (or be left blank if not ranked in the top) indicating whether a cashier is within the top X (depending on the thresholds) based on the number of suspicious receipts.',
	RELEVANT_FOR_MANUAL_REPORT_FG BOOLEAN NOT NULL,
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CASHIER_RANKING_BY_FRAUD_SCENARIO primary key (STORE_SID, CASHIER_NR, SCENARIO_ID)
)COMMENT='Ranks the cashier for a given audit period per scenario per sales_company level'
;