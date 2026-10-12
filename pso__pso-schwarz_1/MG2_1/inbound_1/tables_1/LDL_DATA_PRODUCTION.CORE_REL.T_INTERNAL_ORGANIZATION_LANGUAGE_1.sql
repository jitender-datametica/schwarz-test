create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_INTERNAL_ORGANIZATION_LANGUAGE_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	LANG_USG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how a language may be used. E.g. a language may be used as the official language, another one for price labels and yet another one for handheld devices.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_INTERNAL_ORGANIZATION_LANGUAGE primary key (LANG_USG_TYPE_CD, INT_ORG_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the language preferences for an internal organization. Depending on the purpose, different languages may be used.'
;