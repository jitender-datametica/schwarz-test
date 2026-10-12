CREATE TABLE CORE.T_DIM_CAL_BUSINESS_YEAR_2 (
	BUS_YEAR NUMBER(38,0) NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	BUS_YEAR_BEGIN_MONTH NUMBER(38,0) NOT NULL COMMENT 'The first (calendar_2) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the March of the year specified by the field bus_year. Eg. 201903 for 2019.',
	BUS_YEAR_END_MONTH NUMBER(38,0) NOT NULL COMMENT 'The last (calendar_2) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the February of the year after that specified by the field bus_year.Eg. 202002 for 2019. ',
	BUS_YEAR_BEGIN_DT DATE NOT NULL COMMENT 'The first day (inclusive) of the business year as a conventional calendar_2 date in the form ''YYYY-MM_2-DD''. Eg. ''2019-03-01''.',
	BUS_YEAR_END_DT DATE NOT NULL COMMENT 'The first day (inclusive) of the business year as a conventional calendar_2 date in the form ''YYYY-MM_2-DD''. Eg. ''2020-02-29''. ',
	BUS_YEAR_WEEK_CNT NUMBER(38,0) COMMENT 'The number of weeks that this business year contains. (i,.e. 52 or 53)',
	BUS_YEAR_DAY_CNT NUMBER(38,0) COMMENT 'The number of days that this business year contains. (i,.e. 365 or 366 for leap years)',
	BUS_YEAR_PREV_1Y NUMBER(38,0) NOT NULL COMMENT 'The business year 1 year ago as a number in the form YYYY. E.g. 2018, if the current business year is 2019.',
	BUS_YEAR_PREV_2Y NUMBER(38,0) NOT NULL COMMENT 'The business year 2 years ago as a number in the form YYYY. Eg. 2017, if the current business year is 2019.',
	BUS_YEAR_PREV_3Y NUMBER(38,0) NOT NULL COMMENT 'The business year 3 years ago as a number in the form YYYY. Eg. 2016, if the current business year is 2019.',
	BUS_YEAR_PREV_4Y NUMBER(38,0) NOT NULL COMMENT 'The business year 4 years ago as a number in the form YYYY. Eg. 2015, if the current business year is 2019.',
	BUS_YEAR_PREV_5Y NUMBER(38,0) NOT NULL COMMENT 'The business year 5 years ago as a number in the form YYYY. Eg. 2014, if the current business year is 2019.',
	BUS_YEAR_OFFSET NUMBER(38,0) COMMENT 'The difference in years between this business year and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
    CONSTRAINT PK_T_DIM_CAL_BUSINESS_YEAR PRIMARY KEY (BUS_YEAR) NOT ENFORCED
)COMMENT='Lidl business years, starting in March and ending in February. Eg. Business Year 2019 is March 2019 to February 2020 inclusive.'
;