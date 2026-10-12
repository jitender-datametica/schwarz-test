create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_FACT_NATIONAL_HOLIDAY_1 (
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	ISO_COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the country_1 according to ISO 3166.',
	HOLIDAY_NAME VARCHAR(100) NOT NULL COMMENT 'A name for the holiday in group language, i.e. German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FACT_NATIONAL_HOLIDAY primary key (CAL_DT, ISO_COUNTRY_CD, HOLIDAY_NAME)
)COMMENT='Public holidays which are defined on country_1 level. (This relation does not include regional holidays!)'
;