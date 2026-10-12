create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_HGA_TOTAL_AVAILABILITY_2 (
	HGA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	START_DT DATE NOT NULL COMMENT 'The start date of the source file',
	END_DT DATE NOT NULL COMMENT 'The latest date of the source file',
	TOTAL_AVAIL_PCT NUMBER(38,5) NOT NULL COMMENT 'The total availability measure of machine between the start date and end date of source file',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	LAST_ONLINE_TMSP TIMESTAMP_TZ(9) COMMENT 'The latest timestamp of the report source file for respective machine',
	constraint PK_T_FACT_HGA_TOTAL_AVAILABILITY primary key (HGA_SID)
)COMMENT='Aggregate fact capturing the total availability of machine for a given start and end date'
;