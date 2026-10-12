create or replace TABLE SMP_PRODUCTION.CORE_REL.T_MAP_SHOPPER_DESCR_AUDIENCE (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country iso code',
	SHOPPER_ID VARCHAR(100) NOT NULL COMMENT 'Reference to the shopper masterdata ',
	DESCR_AUDIENCE_ID VARCHAR(100) NOT NULL COMMENT 'Reference to the descriptive audience masterdata',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Mapping between shopper and decriptive audience masterdata'
;
