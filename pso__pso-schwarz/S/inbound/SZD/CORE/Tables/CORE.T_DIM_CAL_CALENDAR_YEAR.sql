CREATE TABLE CORE.T_DIM_CAL_CALENDAR_YEAR (
	CY NUMBER(38,0) NOT NULL COMMENT 'The calendar year as a number in the form YYYY. Eg. 2019',
	CY_BEGIN_MONTH NUMBER(38,0) NOT NULL COMMENT 'The first (calendar) month (inclusive) of the calendar year as a number in the form YYYYMM. Eg. 201901.',
	CY_END_MONTH NUMBER(38,0) NOT NULL COMMENT 'The last (calendar) month (inclusive) of the calendar year as a number in the form YYYYMM. Eg. 201912.',
	CY_BEGIN_WEEK_PART NUMBER(38,0) NOT NULL COMMENT 'The first partial week (inclusive) of the calendar year as a number in the form YYYYWWn. Eg. 2019012.',
	CY_END_WEEK_PART NUMBER(38,0) NOT NULL COMMENT 'The last partial week (inclusive) of the calendar year as a number in the form YYYYWWn. Eg. 2020011.',
	CY_BEGIN_DT DATE NOT NULL COMMENT 'The first day (inclusive) of the calendar year as a conventional calendar date in the form ''YYYY-MM-DD''. Eg. ''2019-01-01''.',
	CY_END_DT DATE NOT NULL COMMENT 'The first day (inclusive) of the calendar year as a conventional calendar date in the form ''YYYY-MM-DD''. Eg. ''2019-12-31''. ',
	CY_WEEK_CNT NUMBER(38,0) COMMENT 'The number of weeks that this calendar year contains. (i,.e. 52 or 53)',
	CY_WEEK_PART_CNT NUMBER(38,0) COMMENT 'The number of partial weeks that this calendar year contains.',
	CY_DAY_CNT NUMBER(38,0) COMMENT 'The number of days that this calendar year contains. (i,.e. 365 or 366 for leap years)',
	CY_PREV_1Y NUMBER(38,0) NOT NULL COMMENT 'The calendar year one year ago as a number in the form YYYY. Eg. 2018, if the current year is 2019.',
	CY_PREV_2Y NUMBER(38,0) NOT NULL COMMENT 'The calendar year two years ago as a number in the form YYYY. Eg. 2017, if the current year is 2019.',
	CY_PREV_3Y NUMBER(38,0) NOT NULL COMMENT 'The calendar year three years ago as a number in the form YYYY. Eg. 2016, if the current year is 2019.',
	CY_PREV_4Y NUMBER(38,0) NOT NULL COMMENT 'The calendar year four years ago as a number in the form YYYY. Eg. 2015, if the current year is 2019.',
	CY_PREV_5Y NUMBER(38,0) NOT NULL COMMENT 'The calendar year five years ago as a number in the form YYYY. Eg. 2014, if the current year is 2019.',
	CY_OFFSET NUMBER(38,0) COMMENT 'The difference in years between this calendar year and the current calendar year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	DWH_SRC_FILE_NAME VARCHAR(250) NOT NULL COMMENT 'The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_CAL_CALENDAR_YEAR PRIMARY KEY (CY)
)COMMENT='Calendar years, starting on January 1st and ending on December 31st.'
;