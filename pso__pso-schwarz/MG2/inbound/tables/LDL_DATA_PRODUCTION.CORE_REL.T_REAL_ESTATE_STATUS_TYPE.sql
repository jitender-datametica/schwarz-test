create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REAL_ESTATE_STATUS_TYPE (
	REAL_ESTATE_STATUS_CATEG_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of status lifecycle for real estate objects.',
	REAL_ESTATE_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status for real estate objects. The status code is related to a given status category.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	REAL_ESTATE_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status for real estate objects.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REAL_ESTATE_STATUS_TYPE primary key (REAL_ESTATE_STATUS_CATEG_CD, REAL_ESTATE_STATUS_CD, LANG_CD)
)COMMENT='This minor entity defines the lifecycle status for real estate objects. E.g. an object may be under contract, open, closed or terminated. There may be more than one lifecycle for a given real estate object, e.g. its status in the source system and its status according to business logic. The lifecycle is identified by the status category code. For a given status category, a real estate object has one status code.'
;