create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_CUST_CLV_BUSYEAR_QTR_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier for client',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'Ceographical identifier for client',
	CURRENCY_ISO_CD VARCHAR(3) NOT NULL COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID NUMBER(38,0) NOT NULL COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	BUSYEAR_QTR NUMBER(38,0) NOT NULL COMMENT 'Business year quarter identifier',
	BUSYEAR_QTR_PREV_1Q NUMBER(38,0) NOT NULL COMMENT 'Quarter of the business one quarter ago',
	BUSYEAR_QTR_PREV_1Y NUMBER(38,0) NOT NULL COMMENT 'Quarter of the business year 1 years ago',
	BUSYEAR_QTR_M_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'ids of monetary segments from rfm model',
	BUSYEAR_QTR_RF_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'ids of recency-frequency segments from rfm model',
	GENDER_CD VARCHAR(5) NOT NULL COMMENT 'The code for the gender',
	AGE_RANGE_CD VARCHAR(10) NOT NULL COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID NUMBER(38,0) DEFAULT 0 COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID NUMBER(38,0) DEFAULT 0 COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	CUSTOMER_SID NUMBER(38,0) NOT NULL COMMENT 'Customer identifier',
	CLV_365_DAYS NUMBER(18,5) COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_CHURN_BUSYEAR_QTR primary key (CLIENT_ID, GEO_AREA_SID, BUSYEAR_QTR, CUSTOMER_SID)
)COMMENT='Lidlplus table :  KPIs show the Lidl Plus sclv 365 per business year quarter'
;
