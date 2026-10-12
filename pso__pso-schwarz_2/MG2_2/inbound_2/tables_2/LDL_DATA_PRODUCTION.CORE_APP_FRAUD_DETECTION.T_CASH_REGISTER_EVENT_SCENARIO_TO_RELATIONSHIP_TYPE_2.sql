create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_SCENARIO_TO_RELATIONSHIP_TYPE_2 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of fraud detection scenario',
	CASH_REGISTER_EVENT_REL_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The way one cash register event is related to another, return to sales_2 receipt (Geldrügabe zu Originalbon) ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CASH_REGISTER_EVENT_SCENARIO_TO_RELATIONSHIP_TYPE primary key (CASH_REGISTER_EVENT_REL_TYPE_CD, SCENARIO_ID)
)COMMENT='Keeps the information which scenario has which relationship type'
;