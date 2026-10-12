CREATE TABLE CORE.T_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_1 (
	CAL_DT DATE NOT NULL COMMENT 'The day being mapped back to previous (business) years, represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	BUS_YEAR_DIFF NUMBER(38,0) NOT NULL COMMENT 'The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.',
	INCL_CAL_DT DATE NOT NULL COMMENT 'The date that needs to be included for the previous year''s equivalent of the current day / partial week being mapped.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'
)COMMENT='This table maps a calendar_1 date to its equivalent day(s) in the previous business years maintaining the weekday (i.e. Monday to Monday) except for the adjusted days at the end of the business year (YYYY-02-28 and YYYY-02-29).'
;