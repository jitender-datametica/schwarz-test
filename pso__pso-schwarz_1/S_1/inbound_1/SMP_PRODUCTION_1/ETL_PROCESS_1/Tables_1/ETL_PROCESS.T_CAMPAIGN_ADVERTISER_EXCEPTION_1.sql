create or replace TABLE SMP_PRODUCTION.ETL_PROCESS.T_CAMPAIGN_ADVERTISER_EXCEPTION_1 (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country_1 iso code',
	CAMPAIGN_ID VARCHAR(100) NOT NULL COMMENT 'Unique identifier of campaign per Source and Country_1',
	CAMPAIGN_NAME VARCHAR(500) NOT NULL COMMENT 'Campaign Name of source system',
	ADVERTISER_ID_SMP VARCHAR(100) COMMENT 'Origin identifier advertiser smp source',
	ADVERTISER_ID_SMP_SPLIT VARCHAR(100) COMMENT 'Split Identifier advertiser',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Campaign advertiser exception for advertiser split which will not delivered per SMP interface, content manually maintained;'
;
