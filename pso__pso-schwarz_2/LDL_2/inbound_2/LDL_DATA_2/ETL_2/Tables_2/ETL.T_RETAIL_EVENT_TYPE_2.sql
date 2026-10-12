CREATE TABLE ETL.T_RETAIL_EVENT_TYPE_2 (
	RETAIL_EVENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for retail events.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	RETAIL_EVENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for retail events.',
	CONSTRAINT PK_T_RETAIL_EVENT_TYPE PRIMARY KEY (RETAIL_EVENT_TYPE_CD, LANG_CD)
);
