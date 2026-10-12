create or replace TABLE SMP_PRODUCTION.INSIGHTS.T_CAMPAIGN_REGISTRATION_DOOH_HIST (
	CAMPAIGN_NAME VARCHAR(16777216) COMMENT 'Campaign name',
	CAMPAIGN_START_DATE DATE COMMENT 'Start date of the campaign',
	CAMPAIGN_END_DATE DATE COMMENT 'End date of the campaign',
	DIVISION_ID VARCHAR(16777216) COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(16777216) COMMENT 'Country iso code',
	PRODUCT_LIST VARCHAR(16777216) COMMENT 'List of promoted articles/gtins',
	TEST_STORE_LIST VARCHAR(16777216) COMMENT 'List of stores of the test group',
	CONTROL_STORE_LIST VARCHAR(16777216) COMMENT 'List of stores of the test group (optional)',
	BUDGET_SPEND FLOAT COMMENT 'Value budget spend (cummulated)',
	ACTIVE_FG NUMBER(38,0) COMMENT 'Flag active/inactive (1/0)',
	DATE_UPDATED TIMESTAMP_NTZ(9) COMMENT 'Timestamp last updated',
	ARCHIVED_AT TIMESTAMP_NTZ(9) COMMENT 'Timestamp of archiving'
)COMMENT='DOOH campaign definition - history/archiv from T_CAMPAIGN_REGISTRATION_DOOH '
;
