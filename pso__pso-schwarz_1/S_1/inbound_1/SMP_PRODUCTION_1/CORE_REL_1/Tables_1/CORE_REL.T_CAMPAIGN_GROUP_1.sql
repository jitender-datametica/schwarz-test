create or replace TABLE SMP_PRODUCTION.CORE_REL.T_CAMPAIGN_GROUP_1 (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country_1 iso code',
	CAMPAIGN_GROUP_ID VARCHAR(100) COMMENT 'Campaign group (only smp), clustering campaigns',
	CAMPAIGN_GROUP_NAME VARCHAR(500) COMMENT 'Name of the campaign group',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job'
)COMMENT='Campaign group masterdata from source system SMP'
;
