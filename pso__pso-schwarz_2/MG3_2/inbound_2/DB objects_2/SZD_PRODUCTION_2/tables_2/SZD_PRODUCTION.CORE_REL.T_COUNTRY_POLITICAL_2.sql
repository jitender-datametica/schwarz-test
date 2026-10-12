create or replace TABLE SZD_PRODUCTION.CORE_REL.T_COUNTRY_POLITICAL_2 (
	LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	ISO_COUNTRY_CD VARCHAR(50) NOT NULL COMMENT 'Natural/Business Key - The code identifying the country_2 according to ISO 3166.',
	COUNTRY_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the country_2 in the default language.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	CURR_CD VARCHAR(50) NOT NULL COMMENT 'The code identifying the official currency of the country_2, according to ISO 4217.',
	LATITUDE NUMBER(9,6) COMMENT 'The latitude of the geographical position of the country.',
	LONGITUDE NUMBER(9,6) COMMENT 'The longitude of the geographical position of the country.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_COUNTRY_POLITICAL primary key (LOCATION_SID, DWH_VALID_FROM_TMSP, LANG_CD)
)COMMENT='Major Entity - A geopolitical region_2 with a sovereign governing. E.g. Germany, France, UK, ... - Source - Manual'
;