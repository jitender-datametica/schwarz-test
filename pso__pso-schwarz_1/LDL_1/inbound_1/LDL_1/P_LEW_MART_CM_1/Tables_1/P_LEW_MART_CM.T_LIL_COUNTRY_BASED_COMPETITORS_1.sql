create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CM.T_LIL_COUNTRY_BASED_COMPETITORS_1 (
	COUNTRY_CD VARCHAR(10) NOT NULL COMMENT 'Country_1 Code',
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Country_1 Identification Number',
	RETAILER_NAME VARCHAR(100) COMMENT 'Retailer name of competitors',
	RETAILER_ID NUMBER(38,0) NOT NULL COMMENT 'Retailer Identification Number',
	COMPETITOR_RANK_NAME VARCHAR(100) COMMENT 'Rank name of competitors',
	COMPETITOR_RANK_ID NUMBER(38,0) NOT NULL COMMENT 'Sequential Identification number of competitors based on ranks',
	ACTIVE_FG NUMBER(38,0) NOT NULL COMMENT 'This field indicates if the record is active or not by 1 or 0.',
	COMPETITOR_RANK_NAME_EN VARCHAR(100) COMMENT 'Rank name of competitors english',
	constraint PK_T_LIL_COUNTRY_BASED_COMPETITORS primary key (CLIENT_ID, RETAILER_ID, COMPETITOR_RANK_ID)
)COMMENT='Mapping table of Cross Country_1 Competitors for Category Management'
;
