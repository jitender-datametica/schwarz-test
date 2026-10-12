create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REAL_ESTATE_STATUS_REASON_2 (
	REAL_ESTATE_STATUS_REASON_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the reason why the status_2 of a real estate object has changed.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	REAL_ESTATE_STATUS_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reason why the status_2 of a real estate object has changed.',
	REAL_ESTATE_STATUS_CATEG_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of status_2 lifecycle for real estate objects.',
	REAL_ESTATE_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status_2 for real estate objects. The status_2 code is related to a given status_2 category.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REAL_ESTATE_STATUS_REASON primary key (REAL_ESTATE_STATUS_REASON_CD, LANG_CD)
)COMMENT='This minor entity defines the reasons why the status_2 of a real estate object has changed.'
;