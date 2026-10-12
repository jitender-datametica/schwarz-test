create or replace TABLE SMP_PRODUCTION.CORE_REL.T_UNIVERSE_SHOPPER_1 (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country_1 iso code',
	UNIVERSE_ID VARCHAR(100) NOT NULL COMMENT 'SMP Universe ID',
	SHOPPER_ID VARCHAR(100) NOT NULL COMMENT 'Reference to the shopper_1',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job',
	UNIVERSE_NAME VARCHAR(1000) NOT NULL COMMENT 'name of the universe from jira task, must match with smp universe name, alternative key for custom_audience',
	CELL_GROUP_ID VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'optional cell group a/b (test_1/control)'
);
