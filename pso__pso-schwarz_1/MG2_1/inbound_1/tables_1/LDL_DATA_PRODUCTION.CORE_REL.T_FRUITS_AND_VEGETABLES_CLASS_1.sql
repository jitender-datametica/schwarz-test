create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_FRUITS_AND_VEGETABLES_CLASS_1 (
	FRUITS_AND_VEGETABLES_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the(quality) class for fruits and vegetables.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	FRUITS_AND_VEGETABLES_CLASS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the (quality) class for fruits and vegetables.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FRUITS_AND_VEGETABLES_CLASS primary key (FRUITS_AND_VEGETABLES_CLASS_CD, LANG_CD)
)COMMENT='This minor entity defines the (quality classes for fruits and vegetables.'
;