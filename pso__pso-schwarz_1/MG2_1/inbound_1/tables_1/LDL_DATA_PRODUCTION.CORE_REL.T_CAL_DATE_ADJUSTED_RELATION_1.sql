create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_DATE_ADJUSTED_RELATION_1 (
	CAL_DT DATE NOT NULL COMMENT 'The day being mapped back to previous (business) years, represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	BUS_YEAR_DIFF NUMBER(38,0) NOT NULL COMMENT 'The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.',
	INCL_CAL_DT DATE NOT NULL COMMENT 'The date that needs to be included for the previous year''s equivalent of the current day being mapped.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_DATE_ADJUSTED_RELATION primary key (CAL_DT, BUS_YEAR_DIFF, INCL_CAL_DT)
)COMMENT='This table maps a calendar_1 date to its equivalent day(s) of previous business years maintaining the same weekday. Mappings for days at the end of the business year are adjusted, so that all mapped days belong to the same business year. In case of leap years this is a many-to-many relation.'
;