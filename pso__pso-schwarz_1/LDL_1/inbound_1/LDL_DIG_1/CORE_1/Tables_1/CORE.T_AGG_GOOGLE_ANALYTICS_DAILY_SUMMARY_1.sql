CREATE TABLE CORE.T_AGG_GOOGLE_ANALYTICS_DAILY_SUMMARY_1 (
	CAL_DT DATE NOT NULL COMMENT 'Date when statistics were tracked',
	COUNTRY_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
	WEB_APP_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The unique identifier (Name)  for type of App( Client)  used to access the Lidl webshop',
	GA_SRC_NAME VARCHAR(5) NOT NULL COMMENT 'The code for the the source of google analytics (WEB or APP)',
	UTM_SOURCE_NAME VARCHAR(100) NOT NULL COMMENT 'Identifies which site sent the traffic (reffered to the Webshop site)',
	UTM_MEDIUM_NAME VARCHAR(100) NOT NULL COMMENT ' Identifies what type of link was used to refer to the webshop',
	VISIT_ALL_CNT NUMBER(38,0) NOT NULL COMMENT 'Count of visits',
	TRANSACTION_CNT NUMBER(38,0) NOT NULL COMMENT 'Count of transactions',
	REVENUE_GROSS_EUR_VAL NUMBER(38,5) NOT NULL COMMENT 'Total revenue in euro',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated',
	DWH_SRC_FILE_NAME VARCHAR(1000) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_AGG_GOOGLE_ANALYTICS_DAIL PRIMARY KEY (CAL_DT, COUNTRY_CD, WEB_APP_TYPE_NAME, GA_SRC_NAME, UTM_SOURCE_NAME, UTM_MEDIUM_NAME)
)COMMENT='A daily summary for google analytics stats (visits, transactions, net spent). Granularity is one row per Day, Country_1, Touchpoint (program used for access), Web_app (browser or app) , Source (UTM_source + UTM_medium)'
;