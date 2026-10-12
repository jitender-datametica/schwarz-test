create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_RVM_CLEANING_PER_WEEK (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CY_WEEK NUMBER(38,0) NOT NULL COMMENT 'The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CLEANING_COMPLETED_WEEKLY_PCT NUMBER(38,5) NOT NULL COMMENT 'The percentage for the completed cleanings per week',
	constraint PK_T_FACT_RVM_CLEANING_PER_WEE primary key (RVM_SID, CY_WEEK)
);