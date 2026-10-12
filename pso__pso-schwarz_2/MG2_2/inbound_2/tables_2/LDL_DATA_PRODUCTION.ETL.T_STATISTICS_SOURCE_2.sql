create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_STATISTICS_SOURCE_2 (
	STAT_SRC_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the source or system which provided the statistics.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	STAT_SRC_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the source or system which provided the statistics.',
	constraint PK_T_STATISTICS_SOURCE primary key (STAT_SRC_CD, LANG_CD)
);