CREATE TABLE CORE.T_DIM_CAL_CALENDAR_YEAR_2 (
	CY NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 year as a number in the form YYYY. Eg. 2019',
	CY_BEGIN_MONTH NUMBER(38,0) NOT NULL COMMENT 'The first (calendar_2) month (inclusive) of the calendar_2 year as a number in the form YYYYMM. Eg. 201901.',
	CY_END_MONTH NUMBER(38,0) NOT NULL COMMENT 'The last (calendar_2) month (inclusive) of the calendar_2 year as a number in the form YYYYMM. Eg. 201912.',
	CY_BEGIN_DT DATE NOT NULL COMMENT 'The first day (inclusive) of the calendar_2 year as a conventional calendar_2 date in the form ''YYYY-MM_2-DD''. Eg. ''2019-01-01''.',
	CY_END_DT DATE NOT NULL COMMENT 'The first day (inclusive) of the calendar_2 year as a conventional calendar_2 date in the form ''YYYY-MM_2-DD''. Eg. ''2019-12-31''. ',
	CY_WEEK_CNT NUMBER(38,0) COMMENT 'The number of weeks that this calendar_2 year contains. (i,.e. 52 or 53)',
	CY_DAY_CNT NUMBER(38,0) COMMENT 'The number of days that this calendar_2 year contains. (i,.e. 365 or 366 for leap years)',
	CY_PREV_1Y NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 year one year ago as a number in the form YYYY. Eg. 2018, if the current year is 2019.',
	CY_PREV_2Y NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 year two years ago as a number in the form YYYY. Eg. 2017, if the current year is 2019.',
	CY_PREV_3Y NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 year three years ago as a number in the form YYYY. Eg. 2016, if the current year is 2019.',
	CY_PREV_4Y NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 year four years ago as a number in the form YYYY. Eg. 2015, if the current year is 2019.',
	CY_PREV_5Y NUMBER(38,0) NOT NULL COMMENT 'The calendar_2 year five years ago as a number in the form YYYY. Eg. 2014, if the current year is 2019.',
	CY_OFFSET NUMBER(38,0) COMMENT 'The difference in years between this calendar_2 year and the current calendar_2 year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
    CONSTRAINT PK_T_DIM_CAL_CALENDAR_YEAR PRIMARY KEY (CY) NOT ENFORCED
)COMMENT='Calendar_2 years, starting on January 1st and ending on December 31st.'
;