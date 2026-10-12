create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP_TYPE_2 (
	CASH_REGISTER_EVENT_REL_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The way one cash register event is related to another, return to sales_2 receipt (Geldrügabe zu Originalbon) ',
	CASH_REGISTER_EVENT_REL_DESCR VARCHAR(250) NOT NULL COMMENT 'Describes the the way how one cash register event is related to another',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CASH_REGISTER_EVENT_RELATIONSHIP_TYPE primary key (CASH_REGISTER_EVENT_REL_TYPE_CD)
)COMMENT='Describes the relationship (between (two cash register events) type'
;