create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_ANALYSIS_STATUS_TYPE (
	FRAUD_ANALYSIS_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'Indicator showing it user has manually clasified this transaction, if it suspicious or not. First status comes: SP-suspicious and then maybe later on NSP- not suspicious',
	FRAUD_ANALYSIS_STATUS_CD_DESCR VARCHAR(250) NOT NULL COMMENT 'Textual description for the marked code',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_ANALYSIS_STATUS_TYPE primary key (FRAUD_ANALYSIS_STATUS_CD)
);