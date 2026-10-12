create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SUSPICIOUS_CASH_REGISTER_EVENT (
	CASH_REGISTER_EVENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.',
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
	FRAUD_ANALYSIS_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The are different status codes.First status code comes: SP-suspicious and then maybe later on NSP- not suspicious',
	COMMENT_TNX VARCHAR(1000) COMMENT 'Describes why the user was clasified the record ( true or  false)',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event is counted.',
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
	CASHIER_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	MARKED_BY_USER_NAME VARCHAR(100) COMMENT 'The MicroStrategy-User who marked the receipt',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRAUD_DETECTION_SUSPICIOUS_CASH_REGISTER_EVENT primary key (CASH_REGISTER_EVENT_SID, SCENARIO_ID)
)COMMENT='From Business User marked receipts, which from his view of point are suspicious'
;