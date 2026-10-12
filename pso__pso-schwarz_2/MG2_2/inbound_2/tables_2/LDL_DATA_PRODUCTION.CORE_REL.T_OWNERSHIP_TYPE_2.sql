create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_OWNERSHIP_TYPE_2 (
	OWNERSHIP_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	OWNERSHIP_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the ownership type of a real estate object,',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_OWNERSHIP_TYPE primary key (OWNERSHIP_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'
;