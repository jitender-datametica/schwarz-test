create or replace TABLE SMP_PRODUCTION.ETL_PROCESS.T_REF_CHANNEL_MAP (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country iso code',
	VERTICAL VARCHAR(100) COMMENT 'Vertical Description (e.g. App, Website....)',
	CHANNEL_ID VARCHAR(100) COMMENT 'Reference channel from sourcesystem(e.g. lidl plus app) ',
	CHANNEL_ID_MAP VARCHAR(100) COMMENT 'Reference channel from sourcesystem(e.g. lidl plus app)',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Mapping Channel Description, manually maintained and optional (see also SMST-1795)'
;
