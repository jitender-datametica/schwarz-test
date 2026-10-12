create or replace TABLE SMP_PRODUCTION.CORE_REL.T_DESCR_AUDIENCE (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country iso code',
	DESCR_AUDIENCE_TYPE_ID VARCHAR(100) NOT NULL COMMENT 'Reference to the descriptive audience type',
	DESCR_AUDIENCE_ID VARCHAR(100) NOT NULL COMMENT 'ID of the descriptive audience, e.g. AGE00001',
	DESCR_AUDIENCE_NAME VARCHAR(16777216) NOT NULL COMMENT 'Description of the descriptive audience',
	DESCR_AUDIENCE_VALUE VARCHAR(16777216) NOT NULL COMMENT 'Value of the descriptive audience',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Decriptive audience masterdata, e.g. age 1-10 years, male, zipcode'
;
