create or replace TABLE SMP_PRODUCTION.CORE_REL.T_DESCR_AUDIENCE_TYPE (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country iso code',
	DESCR_AUDIENCE_SEGMENT_ID VARCHAR(100) NOT NULL COMMENT 'Segment of the type, e.g. Demographic',
	DESCR_AUDIENCE_TYPE_ID VARCHAR(100) NOT NULL COMMENT 'Key of the type, eg. AGE, GENDER, ZIP',
	DESCR_AUDIENCE_TYPE_NAME VARCHAR(16777216) NOT NULL COMMENT 'Description of the type',
	ACTIVE_FG NUMBER(38,0) NOT NULL COMMENT 'Flag for the Acitvity, indicates the usage for SMP Interface',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Decriptive audience type masterdata, e.g. age, gender, zipcode'
;
