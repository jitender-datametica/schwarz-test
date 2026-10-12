create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_RVM_DOWNTIME_STATISTICS_2 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
	TOTAL_DOWNTIME_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of full outages this machine suffered on this component in the given time interval.',
	DOWNTIME_NO_ELECTRICITY_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of partial outages this machine suffered on this component in the given time interval.',
	DOWNTIME_OTHER_RSN_SEC_CNT NUMBER(38,0) NOT NULL COMMENT 'The total time (expressed as a number of seconds) this machine was not operational because of outages of this component in the given time interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_RVM_DOWNTIME_STATIST primary key (RVM_SID, CAL_DT)
)COMMENT='Analytical facts holding downtime statistics for deposit machines.'
;