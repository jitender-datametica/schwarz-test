create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PLANNED_VALUE_ROLE_1 (
	PLANNED_VAL_ROLE_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the role or context for which the value is planned.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PLANNED_VAL_ROLE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the role or context for which the value is planned.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PLANNED_VALUE_ROLE primary key (PLANNED_VAL_ROLE_CD, LANG_CD)
)COMMENT='The planned value may play a certain role or be put into a certain context. E.g. revenue for an internal company may be planned both for its role as a sales_1 company and for its role as a delivery company. Different values may be planned for each role.'
;