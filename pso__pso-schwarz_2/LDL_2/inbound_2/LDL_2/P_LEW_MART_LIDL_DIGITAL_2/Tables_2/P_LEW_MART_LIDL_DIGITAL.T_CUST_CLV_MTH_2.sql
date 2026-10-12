create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_CUST_CLV_MTH_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier for client',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'Ceographical identifier for client',
	CURRENCY_ISO_CD VARCHAR(3) NOT NULL COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID NUMBER(38,0) NOT NULL COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'Calendar_2 Year+Month in form YYYYMM',
	CY_MONTH_PREV_1M NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'The calendar_2 month 1 month ago as a number in the form YYYYMM. Eg. 201901. [Month Identifier]',
	CY_MONTH_PREV_1Y NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'The calendar_2 month 1 year ago as a number in the form YYYYMM. Eg. 201802. [Month Identifier]',
	MTH_RF_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_M_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of monetary segments from rfm model',
	GENDER_CD VARCHAR(5) NOT NULL COMMENT 'The code for the gender',
	AGE_RANGE_CD VARCHAR(10) NOT NULL COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID NUMBER(38,0) DEFAULT 0 COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID NUMBER(38,0) DEFAULT 0 COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	CUSTOMER_SID NUMBER(38,0) NOT NULL COMMENT 'Customer identifier',
	CLV_365_DAYS NUMBER(18,5) COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_CHURN_MTH primary key (CLIENT_ID, GEO_AREA_SID, CY_MONTH, CUSTOMER_SID)
)COMMENT='Lidlplus table :  KPIs show the Lidl Plus clv 365 per month'
;
