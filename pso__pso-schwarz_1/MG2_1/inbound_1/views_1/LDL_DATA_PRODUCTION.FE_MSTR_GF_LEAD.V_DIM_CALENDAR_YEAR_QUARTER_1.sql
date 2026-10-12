create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_CALENDAR_YEAR_QUARTER_1(
	CAL_YEAR_QTR COMMENT 'The quarter of a calendar_1 year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.',
	CAL_YEAR COMMENT 'The calendar_1 year as a number in the form YYYY. Eg. 2019',
	CAL_HALF_YEAR COMMENT 'The identifier for a calendar_1 half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.',
	CAL_YEAR_QTR_NAME COMMENT 'The text which is displayed for the quarter of the calendar_1 year in reports, in group language, i.e. German. E.g. Q1/2021 for the first quarter of the calendar_1 year 2021.',
	CAL_YEAR_QTR_NAME_DE COMMENT 'The text which is displayed for the quarter of the calendar_1 year in reports, in German. E.g. Q1/2021 for the first quarter of the calendar_1 year 2021.',
	CAL_YEAR_QTR_NAME_EN COMMENT 'The text which is displayed for the quarter of the calendar_1 year in reports, in English. E.g. Q1/2021 for the first quarter of the calendar_1 year 2021.',
	QTR_OF_CAL_YEAR COMMENT 'The number of the quarter within the calendar_1 year. E.g. 3 for Q3/2021.',
	CAL_YEAR_QTR_BEGIN_MONTH COMMENT 'The first (calendar_1) month (inclusive) of the calendar_1 year quarter as a number in the form YYYYMM. Eg. 202101.',
	CAL_YEAR_QTR_END_MONTH COMMENT 'The last (calendar_1) month (inclusive) of the calendar_1 year quarter as a number in the form YYYYMM. Eg. 202103.',
	CAL_YEAR_QTR_BEGIN_PART_WEEK COMMENT 'The first partial week (inclusive) of the calendar_1 year quarter as a number in the form YYYYWWn. Eg. 2021011.',
	CAL_YEAR_QTR_END_PART_WEEK COMMENT 'The last partial week (inclusive) of the calendar_1 year quarter as a number in the form YYYYWWn. Eg. 2021131.',
	CAL_YEAR_QTR_BEGIN_DT COMMENT 'The first day (inclusive) of the calendar_1 year quarter as a conventional calendar_1 date in the form ''YYYY-MM_1-DD''. Eg. ''2021-01-01''.',
	CAL_YEAR_QTR_END_DT COMMENT 'The first day (inclusive) of the calendar_1 year quarter as a conventional calendar_1 date in the form ''YYYY-MM_1-DD''. Eg. ''2021-03-31''. ',
	CAL_YEAR_QTR_WEEK_CNT COMMENT 'The number of weeks that this calendar_1 year quarter contains. If a week spans two quarters, it is counted for the quarter, in which it has at least four days.',
	CAL_YEAR_QTR_PART_WEEK_CNT COMMENT 'The number of partial weeks that this calendar_1 year quarter contains.',
	CAL_YEAR_QTR_DAY_CNT COMMENT 'The number of days that this calendar_1 year quarter contains.',
	PREV_1Y_CAL_YEAR_QTR COMMENT 'The calendar_1 year quarter one year ago as a number in the form YYYYn. Eg. 20201, if the current quarter is 20211.',
	PREV_2Y_CAL_YEAR_QTR COMMENT 'The calendar_1 year quarter two years ago as a number in the form YYYYn. Eg. 20191, if the current quarter is 20211.',
	PREV_3Y_CAL_YEAR_QTR COMMENT 'The calendar_1 year quarter three years ago as a number in the form YYYYn. Eg. 20181, if the current quarter is 20211.',
	PREV_4Y_CAL_YEAR_QTR COMMENT 'The calendar_1 year quarter four years ago as a number in the form YYYYn. Eg. 20171, if the current quarter is 20211.',
	PREV_5Y_CAL_YEAR_QTR COMMENT 'The calendar_1 year quarter five years ago as a number in the form YYYYn. Eg. 20161, if the current quarter is 20211.',
	CURR_CAL_YEAR_QTR_FG COMMENT 'This indicator is set for the current quarter of the calendar_1 year.',
	CAL_YEAR_QTR_OFFSET COMMENT 'The difference in calendar_1 year quarters between this calendar_1 year quarter and the current calendar_1 year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	CAL_HALF_YEAR_OFFSET COMMENT 'The difference in calendar_1 half years between the calendar_1 half year to which this quarter belongs, and the current calendar_1 half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	CAL_YEAR_OFFSET COMMENT 'The difference in years between the calendar_1 year to which this quarter belongs, and the current calendar_1 year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The quarter of a calendar_1 year, e.g. Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.'
 as SELECT
main.cal_year_qtr AS cal_year_qtr
,main.cal_year AS cal_year
,main.cal_half_year AS cal_half_year
,main.cal_year_qtr_name AS cal_year_qtr_name
,main.cal_year_qtr_name_de AS cal_year_qtr_name_de
,main.cal_year_qtr_name_en AS cal_year_qtr_name_en
,main.qtr_of_cal_year AS qtr_of_cal_year
,main.cal_year_qtr_begin_month AS cal_year_qtr_begin_month
,main.cal_year_qtr_end_month AS cal_year_qtr_end_month
,main.cal_year_qtr_begin_part_week AS cal_year_qtr_begin_part_week
,main.cal_year_qtr_end_part_week AS cal_year_qtr_end_part_week
,main.cal_year_qtr_begin_dt AS cal_year_qtr_begin_dt
,main.cal_year_qtr_end_dt AS cal_year_qtr_end_dt
,main.cal_year_qtr_week_cnt AS cal_year_qtr_week_cnt
,main.cal_year_qtr_part_week_cnt AS cal_year_qtr_part_week_cnt
,main.cal_year_qtr_day_cnt AS cal_year_qtr_day_cnt
,main.prev_1y_cal_year_qtr AS prev_1y_cal_year_qtr
,main.prev_2y_cal_year_qtr AS prev_2y_cal_year_qtr
,main.prev_3y_cal_year_qtr AS prev_3y_cal_year_qtr
,main.prev_4y_cal_year_qtr AS prev_4y_cal_year_qtr
,main.prev_5y_cal_year_qtr AS prev_5y_cal_year_qtr
,main.curr_cal_year_qtr_fg AS curr_cal_year_qtr_fg
,main.cal_year_qtr_offset AS cal_year_qtr_offset
,main.cal_half_year_offset AS cal_half_year_offset
,main.cal_year_offset AS cal_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_CALENDAR_YEAR_QUARTER_1 main 
WHERE main.cal_year_offset BETWEEN -20 AND 2 ;