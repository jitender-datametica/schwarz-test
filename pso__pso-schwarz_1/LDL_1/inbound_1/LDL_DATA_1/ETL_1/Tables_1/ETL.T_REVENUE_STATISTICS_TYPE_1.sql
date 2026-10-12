CREATE TABLE ETL.T_REVENUE_STATISTICS_TYPE_1 (
	REVENUE_STAT_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the subtype discriminator for revenue statisticss.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	REVENUE_STAT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for revenue statisticss.',
	CONSTRAINT PK_T_REVENUE_STATISTICS_TYPE PRIMARY KEY (REVENUE_STAT_TYPE_ID, LANG_CD)
);
