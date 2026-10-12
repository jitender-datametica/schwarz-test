CREATE TABLE CORE.T_AGG_GOOGLE_ANALYTICS_HOURLY_SUMMARY_2 (
	WSHOP_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
	CAL_DT DATE NOT NULL,
	CAL_TM TIME(6) NOT NULL,
	GA_SRC_NAME VARCHAR(5) NOT NULL COMMENT 'The name for the the source of google analytics (WEB or APP)',
	USER_CNT_VAL NUMBER(38,5),
	SESSION_CNT_VAL NUMBER(38,5),
	TRANSACTION_CNT_VAL NUMBER(38,5),
	UNIQUE_PAGE_VIEW_CNT_VAL NUMBER(38,5),
	SESSIONS_PER_USER_CNT_VAL NUMBER(38,5),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_AGG_GOOGLE_ANALYTICS_HOUR PRIMARY KEY (WSHOP_CD, CAL_DT, CAL_TM,GA_SRC_NAME)
);