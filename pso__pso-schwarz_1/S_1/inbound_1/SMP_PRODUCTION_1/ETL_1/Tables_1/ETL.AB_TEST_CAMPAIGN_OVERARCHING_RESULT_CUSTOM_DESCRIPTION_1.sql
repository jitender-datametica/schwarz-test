create or replace TABLE SMP_PRODUCTION.ETL.AB_TEST_CAMPAIGN_OVERARCHING_RESULT_CUSTOM_DESCRIPTION_1 (
	DESCRIPTION VARCHAR(16777216) COMMENT 'utf8 string(int) description',
	SMP_ID VARCHAR(100) COMMENT 'utf8 string(int) smp_id',
	PIQ_ID VARCHAR(100) COMMENT 'utf8 string(int) piq_id',
	AB_TEST_CAMPAIGN_ID VARCHAR(100) COMMENT 'utf8 string(int) ab_test_campaign_id',
	AUTHOR VARCHAR(100) COMMENT 'utf8 string(int) author',
	CREATED_AT VARCHAR(100) COMMENT 'utf8 string(int) created_at',
	FILE_NAME VARCHAR(16777216) COMMENT 'source file name',
	LOAD_TIMESTAMP TIMESTAMP_NTZ(9) COMMENT 'Timestamp for loading'
);
