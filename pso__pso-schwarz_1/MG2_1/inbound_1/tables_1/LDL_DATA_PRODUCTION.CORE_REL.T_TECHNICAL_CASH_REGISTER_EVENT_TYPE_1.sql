create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_TYPE_1 (
	TECH_CASH_REGISTER_EVENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of technical cash register event.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	TECH_CASH_REGISTER_EVENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of technical cash register event.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_TECHNICAL_CASH_REGISTER_EVENT_TYPE primary key (TECH_CASH_REGISTER_EVENT_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the kind of technical cash register event. E.g. loging on or off, locking the cash register, etc.'
;