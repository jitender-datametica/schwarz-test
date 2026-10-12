CREATE TABLE CORE.T_CAL_DAY_PY_BUSINESS_YEAR_ADJUSTED_2 (
	CAL_DT DATE NOT NULL COMMENT 'The day being mapped back to previous (business) years, represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
	BUS_YEAR_DIFF NUMBER(38,0) NOT NULL COMMENT 'The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.',
	INCL_CAL_DT DATE NOT NULL COMMENT 'The date that needs to be included for the previous year''s equivalent of the current day being mapped.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'
)COMMENT='This table maps a calendar_2 date to its equivalent day(s) of previous business years maintaining the calendar_2 date (e.g. 27.5.2019 -> 27.5.2018) except for the adjusted days at the end of the business year (YYYY-02-28 and YYYY-02-29).'
;