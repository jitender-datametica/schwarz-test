create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_CABINET_USAGE_2 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
	COMPACTOR_ID VARCHAR(20) NOT NULL COMMENT 'The identifier for the amount of Compactors under a cabinet.',
	COMPACTED_BOTTLES_CNT NUMBER(38,0) NOT NULL COMMENT 'The transactional facts for the amount of compacted bottles',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CABINET_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the amount of Cabinets in a RVM',
	constraint PK_T_FACT_CABINET_USAGE primary key (RVM_SID, CAL_DT, CABINET_ID)
)COMMENT='Transactional facts capturing the cabinets of deposit machines'
;