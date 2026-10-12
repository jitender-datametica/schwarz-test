create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_RETAIL_EVENT_TYPE (
	RETAIL_EVENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for retail events.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	RETAIL_EVENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for retail events.',
	constraint PK_T_RETAIL_EVENT_TYPE primary key (RETAIL_EVENT_TYPE_CD, LANG_CD)
);