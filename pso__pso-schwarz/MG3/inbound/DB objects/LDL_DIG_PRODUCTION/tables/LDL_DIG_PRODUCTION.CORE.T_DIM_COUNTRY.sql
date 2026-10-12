create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_COUNTRY (
	COUNTRY_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France',
	COUNTRY_NAME VARCHAR(250) NOT NULL COMMENT 'The textual description for the country',
	COUNTRY_ISO3_CD VARCHAR(5) COMMENT 'ISO Alpha 3-letter-code',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_T_DIM_COUNTRY primary key (COUNTRY_CD)
)COMMENT='This minor dimension defines the country'
;