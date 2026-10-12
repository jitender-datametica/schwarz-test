create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_BUSINESS_YEAR_1(
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	BUS_YEAR_BEGIN_MONTH COMMENT 'The first (calendar_1) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the March of the year specified by the field bus_year. Eg. 201903 for 2019.',
	BUS_YEAR_END_MONTH COMMENT 'The last (calendar_1) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the February of the year after that specified by the field bus_year.Eg. 202002 for 2019. ',
	BUS_YEAR_BEGIN_PART_WEEK COMMENT 'The first partial week (inclusive) of the business year as a number in the form YYYYWWn. Eg. 2019092.',
	BUS_YEAR_END_PART_WEEK COMMENT 'The last partial week (inclusive) of the business year as a number in the form YYYYWWn. Eg. 2020091.',
	BUS_YEAR_BEGIN_DT COMMENT 'The first day (inclusive) of the business year as a conventional calendar_1 date in the form ''YYYY-MM_1-DD''. Eg. ''2019-03-01''.',
	BUS_YEAR_END_DT COMMENT 'The first day (inclusive) of the business year as a conventional calendar_1 date in the form ''YYYY-MM_1-DD''. Eg. ''2020-02-29''. ',
	BUS_YEAR_WEEK_CNT COMMENT 'The number of weeks that this business year contains. (i,.e. 52 or 53) If a week spans two business years, it is counted for the year, in which it has at least four days.',
	BUS_YEAR_PART_WEEK_CNT COMMENT 'The number of partial weeks that this business year contains.',
	BUS_YEAR_DAY_CNT COMMENT 'The number of days that this business year contains. (i,.e. 365 or 366 for leap years)',
	LEAP_YEAR_FG COMMENT 'An indicator showing, if this year is a leap year, i.e. if it has 366 days.',
	PREV_1Y_BUS_YEAR COMMENT 'The business year 1 year ago as a number in the form YYYY. E.g. 2018, if the current business year is 2019.',
	PREV_2Y_BUS_YEAR COMMENT 'The business year 2 years ago as a number in the form YYYY. Eg. 2017, if the current business year is 2019.',
	PREV_3Y_BUS_YEAR COMMENT 'The business year 3 years ago as a number in the form YYYY. Eg. 2016, if the current business year is 2019.',
	PREV_4Y_BUS_YEAR COMMENT 'The business year 4 years ago as a number in the form YYYY. Eg. 2015, if the current business year is 2019.',
	PREV_5Y_BUS_YEAR COMMENT 'The business year 5 years ago as a number in the form YYYY. Eg. 2014, if the current business year is 2019.',
	CURR_BUS_YEAR_FG COMMENT 'This indicator is set for the current business year.',
	BUS_YEAR_OFFSET COMMENT 'The difference in years between this business year and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  ',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Lidl business years, starting in March and ending in February. Eg. Business Year 2019 is March 2019 to February 2020 inclusive.'
 as SELECT
main.bus_year AS bus_year
,main.bus_year_begin_month AS bus_year_begin_month
,main.bus_year_end_month AS bus_year_end_month
,main.bus_year_begin_part_week AS bus_year_begin_part_week
,main.bus_year_end_part_week AS bus_year_end_part_week
,main.bus_year_begin_dt AS bus_year_begin_dt
,main.bus_year_end_dt AS bus_year_end_dt
,main.bus_year_week_cnt AS bus_year_week_cnt
,main.bus_year_part_week_cnt AS bus_year_part_week_cnt
,main.bus_year_day_cnt AS bus_year_day_cnt
,main.leap_year_fg AS leap_year_fg
,main.prev_1y_bus_year AS prev_1y_bus_year
,main.prev_2y_bus_year AS prev_2y_bus_year
,main.prev_3y_bus_year AS prev_3y_bus_year
,main.prev_4y_bus_year AS prev_4y_bus_year
,main.prev_5y_bus_year AS prev_5y_bus_year
,main.curr_bus_year_fg AS curr_bus_year_fg
,main.bus_year_offset AS bus_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_BUSINESS_YEAR_1 main 
WHERE main.bus_year_offset BETWEEN -20 AND 2 ;