create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_RVM_DOWNTIME_STATISTICS (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
	TOTAL_DOWNTIME_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of full outages this machine suffered on this component in the given time interval.',
	DOWNTIME_NO_ELECTRICITY_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of partial outages this machine suffered on this component in the given time interval.',
	DOWNTIME_OTHER_RSN_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The total time (expressed as a number of seconds) this machine was not operational because of outages of this component in the given time interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_RVM_DOWNTIME_STATIST primary key (RVM_SID, CAL_DT)
);