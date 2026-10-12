create or replace TABLE SMP_PRODUCTION.CORE_REL.T_UNIVERSE_2 (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country_2 iso code',
	UNIVERSE_ID VARCHAR(100) NOT NULL COMMENT 'SMP Universe ID',
	UNIVERSE_NAME VARCHAR(1000) NOT NULL COMMENT 'Name of the Universe from jira Task, must match with SMP Universe Name, Alternative key for custom_audience',
	SOURCE_SYSTEM_ID VARCHAR(100) NOT NULL COMMENT 'Sourcesystem, e.g. DWH, SMP, PIQ',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Generated load id of the transformation job',
	JIRA_TASK_LINK VARCHAR(1000) NOT NULL DEFAULT '' COMMENT 'Link of the jira task in case for the AB universe request',
	ADVERTISER_ID_SMP VARCHAR(100) COMMENT 'Identifier advertiser smp source',
	UNIVERSE_CATEGORY VARCHAR(1000) COMMENT 'optioinal category for unverses/audiences (only las/pexa) ',
	UNIVERSE_TYPE_ID VARCHAR(100) COMMENT 'optional type for universes/audiences (only las/pexa)',
	UNIVERSE_ID_OPT VARCHAR(100) COMMENT 'alternativ universe reference from sourcesystems (e.g. las/pexa)'
);
