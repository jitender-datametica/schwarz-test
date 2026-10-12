create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_COUNTRY_2 (
	COUNTRY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	ISO_COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the country_2 according to ISO 3166.',
	COUNTRY_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the country_2 is known,',
	CURR_CD VARCHAR(3) COMMENT 'The code identifying the official currency of the country_2, according to ISO 4217.',
	OFFICIAL_LANG_CD VARCHAR(2) COMMENT 'The code identifying the primary language that is used in this country.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint AK_ALTERNATE_KEY_T_COUNTR unique (ISO_COUNTRY_CD),
	constraint PK_T_COUNTRY primary key (COUNTRY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A geopolitical region_2 with a sovereign governing. E.g. Germany, France, UK, ...'
;