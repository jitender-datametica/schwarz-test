create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_RVM_MONITORING_1 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	FILES_EXP_CNT NUMBER(38,0) COMMENT 'The Counter for expected Files',
	FILES_MISS_CNT NUMBER(38,0) COMMENT 'The Counter for missing Files',
	constraint PK_T_FACT_RVM_MONITORING primary key (RVM_SID, CAL_DT)
)COMMENT='Transactional facts capturing preventive maintenance operations of deposit machines.'
;