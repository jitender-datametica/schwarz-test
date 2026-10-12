create or replace TABLE SMP_PRODUCTION.ETL_PROCESS.T_AB_UNIVERSE_CELL_GROUP (
	DIVISION_ID VARCHAR(100) NOT NULL COMMENT 'LDL or KFL',
	COUNTRY_ID VARCHAR(100) NOT NULL COMMENT 'Country Iso Code',
	UNIVERSE_NAME VARCHAR(100) NOT NULL COMMENT 'Name of the Universe from jira Task, must match with SMP Universe Name',
	JIRA_TASK_LINK VARCHAR(1000) NOT NULL DEFAULT '' COMMENT 'Link of the jira task for the AB universe request ',
	SHOPPER_ID VARCHAR(100) NOT NULL COMMENT 'Reference to the shopper ',
	CELL_GROUP_ID VARCHAR(10) NOT NULL COMMENT 'Cell group A/B (Test/Control)',
	ADVERTISER_ID_SMP VARCHAR(100) COMMENT 'Referenct to the SMP Advertiser',
	CREATE_TMSP TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp of creation, only for information, current_timestamp of inserting the data'
);
