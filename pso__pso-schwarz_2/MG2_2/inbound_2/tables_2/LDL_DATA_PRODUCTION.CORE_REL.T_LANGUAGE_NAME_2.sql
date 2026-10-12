create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_LANGUAGE_NAME_2 (
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	DISPLAY_LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	LANG_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the language in the language indicated by the display language code.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_LANGUAGE_NAME primary key (LANG_CD, DISPLAY_LANG_CD)
)COMMENT='This table provides the translations of the language names in multiple languages.'
;