create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_HGA_MAINTENANCE (
	HGA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	REPORT_DT DATE NOT NULL COMMENT 'The date on which the report is generated',
	CLEANING_LIQUID_LTR_QTY NUMBER(38,5) COMMENT 'The measure of cleaning liquid solution in litre',
	SERVICE_CNT NUMBER(38,0) NOT NULL COMMENT 'The counter of services happened on the machine for a report date',
	FILTER_CNT NUMBER(38,0) NOT NULL COMMENT 'The counter of filter on the machine for a report date',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CLEANING_CNT NUMBER(38,0) NOT NULL COMMENT 'The counter of cleaning done on machine for a report date',
	DOOR_OPEN_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of times the door has been opened on a report date (derived from the error table based on the error type and status)',
	constraint PK_T_FACT_HGA_MAINTENANCE primary key (HGA_SID, REPORT_DT)
)COMMENT='Periodic snapshot fact table storing the measures such as the maintanence and cleaning operation counters of the machine as of the reported date'
;