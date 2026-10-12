create or replace TABLE SMP_PRODUCTION.CORE_REL.T_DESCR_AUDIENCE_SEGMENT_2 (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country_2 iso code',
	DESCR_AUDIENCE_SEGMENT_ID VARCHAR(100) NOT NULL COMMENT 'Segment of the type, e.g. Demographic',
	DESCR_AUDIENCE_SEGMENT_NAME VARCHAR(16777216) NOT NULL COMMENT 'Description of the segment',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Decriptive audience segment masterdata, e.g. Demographic'
;
