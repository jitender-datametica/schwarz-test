create or replace TABLE SMP_PRODUCTION.INSIGHTS.T_CAMPAIGN_REGISTRATION_PEXA (
	CAMPAIGN_NAME VARCHAR(16777216) NOT NULL COMMENT 'Unique campaign name',
	CAMPAIGN_START_DATE DATE COMMENT 'Start date of the campaign',
	CAMPAIGN_END_DATE DATE COMMENT 'End date of the campaign',
	DIVISION_ID VARCHAR(16777216) COMMENT 'Division Lidl or Kaufland (LDL/KFL)',
	COUNTRY_ID VARCHAR(16777216) COMMENT 'Country iso code',
	PRODUCT_LIST VARCHAR(16777216) COMMENT 'List of promoted articles/gtins',
	BUDGET_SPEND FLOAT COMMENT 'Value budget spend (cummulated)',
	ACTIVE_FG NUMBER(38,0) COMMENT 'Flag active/inactive (1/0)',
	DATE_UPDATED TIMESTAMP_NTZ(9) COMMENT 'Timestamp last updated',
	AUDIENCE_CATEGORY VARCHAR(16777216) COMMENT 'Audience categeory (audience grouping)',
	AUDIENCE_NAME VARCHAR(16777216) COMMENT 'Audience name',
	AUDIENCE_TYPE VARCHAR(16777216) COMMENT 'Audience type p/r',
	primary key (CAMPAIGN_NAME)
)COMMENT='Pexa campaign definition - writeback from smi dashboard'
;
