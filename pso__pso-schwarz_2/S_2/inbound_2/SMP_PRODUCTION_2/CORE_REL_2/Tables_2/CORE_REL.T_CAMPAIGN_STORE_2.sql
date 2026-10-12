create or replace TABLE SMP_PRODUCTION.CORE_REL.T_CAMPAIGN_STORE_2 (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country_2 iso code',
	DIVISION_COUNTRY_REF NUMBER(38,0) COMMENT 'Country_2 Reference of division',
	CAMPAIGN_ID VARCHAR(100) NOT NULL COMMENT 'Unique identifier of campaign per Source and Country_2',
	STORE_ID VARCHAR(100) NOT NULL COMMENT 'Unique identifier of a store per division and Country_2',
	STORE_ID_REF NUMBER(38,0) NOT NULL COMMENT 'Alternative unique identifier of a store per division and Country_2',
	CELL_GROUP_ID VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'Optional cell group a/b (Test_2/Control)',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
);
