create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_BUSINESS_YEAR_QUARTER(
	BUS_YEAR_QTR COMMENT 'The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. ',
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	BUS_HALF_YEAR COMMENT 'The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.',
	BUS_YEAR_QTR_NAME COMMENT 'The text which is displayed for the quarter of the business year in reports, in group language, i.e. German. E.g. Q1/2021 for the first quarter of the business year 2021.',
	BUS_YEAR_QTR_NAME_DE COMMENT 'The text which is displayed for the quarter of the business year in reports, in German. E.g. Q1/2021 for the first quarter of the business year 2021.',
	BUS_YEAR_QTR_NAME_EN COMMENT 'The text which is displayed for the quarter of the business year in reports, in English. E.g. Q1/2021 for the first quarter of the business year 2021.',
	QTR_OF_BUS_YEAR COMMENT 'The number of the quarter within the business year. E.g. 3 for Q3/2021.',
	BUS_YEAR_QTR_BEGIN_MONTH COMMENT 'The first (calendar) month (inclusive) of the business year quarter as a number in the form YYYYMM. Eg. 202101.',
	BUS_YEAR_QTR_END_MONTH COMMENT 'The last (calendar) month (inclusive) of the business year quarter as a number in the form YYYYMM. Eg. 202103.',
	BUS_YEAR_QTR_BEGIN_PART_WEEK COMMENT 'The first partial week (inclusive) of the business year quarter as a number in the form YYYYWWn. Eg. 2021011.',
	BUS_YEAR_QTR_END_PART_WEEK COMMENT 'The last partial week (inclusive) of the business year quarter as a number in the form YYYYWWn. Eg. 2021131.',
	BUS_YEAR_QTR_BEGIN_DT COMMENT 'The first day (inclusive) of the business year quarter as a conventional calendar date in the form ''YYYY-MM-DD''. Eg. ''2021-01-01''.',
	BUS_YEAR_QTR_END_DT COMMENT 'The first day (inclusive) of the business year quarter as a conventional calendar date in the form ''YYYY-MM-DD''. Eg. ''2021-03-31''. ',
	BUS_YEAR_QTR_WEEK_CNT COMMENT 'The number of weeks that this business year quarter contains. If a week spans two quarters, it is counted for the quarter, in which it has at least four days.',
	BUS_YEAR_QTR_PART_WEEK_CNT COMMENT 'The number of partial weeks that this business year quarter contains.',
	BUS_YEAR_QTR_DAY_CNT COMMENT 'The number of days that this business year quarter contains.',
	PREV_1Y_BUS_YEAR_QTR COMMENT 'The business year quarter one year ago as a number in the form YYYYn. Eg. 20201, if the current quarter is 20211.',
	PREV_2Y_BUS_YEAR_QTR COMMENT 'The business year quarter two years ago as a number in the form YYYYn. Eg. 20191, if the current quarter is 20211.',
	PREV_3Y_BUS_YEAR_QTR COMMENT 'The business year quarter three years ago as a number in the form YYYYn. Eg. 20181, if the current quarter is 20211.',
	PREV_4Y_BUS_YEAR_QTR COMMENT 'The business year quarter four years ago as a number in the form YYYYn. Eg. 20171, if the current quarter is 20211.',
	PREV_5Y_BUS_YEAR_QTR COMMENT 'The business year quarter five years ago as a number in the form YYYYn. Eg. 20161, if the current quarter is 20211.',
	CURR_BUS_YEAR_QTR_FG COMMENT 'This indicator is set for the current quarter of the business year.',
	BUS_YEAR_QTR_OFFSET COMMENT 'The difference in business year quarters between this business year quarter and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	BUS_HALF_YEAR_OFFSET COMMENT 'The difference in business half years between the business half year to which this business year quarter belongs, and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	BUS_YEAR_OFFSET COMMENT 'The difference in years between the business year to which this business half quarter belongs, and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  ',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The quarter of the business year, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. (Q1 includes March, April and May. Q2 includes June, July and August. Q3 includes September, October and November. Q4 includes December, January and February.)'
 as SELECT
main.bus_year_qtr AS bus_year_qtr
,main.bus_year AS bus_year
,main.bus_half_year AS bus_half_year
,main.bus_year_qtr_name AS bus_year_qtr_name
,main.bus_year_qtr_name_de AS bus_year_qtr_name_de
,main.bus_year_qtr_name_en AS bus_year_qtr_name_en
,main.qtr_of_bus_year AS qtr_of_bus_year
,main.bus_year_qtr_begin_month AS bus_year_qtr_begin_month
,main.bus_year_qtr_end_month AS bus_year_qtr_end_month
,main.bus_year_qtr_begin_part_week AS bus_year_qtr_begin_part_week
,main.bus_year_qtr_end_part_week AS bus_year_qtr_end_part_week
,main.bus_year_qtr_begin_dt AS bus_year_qtr_begin_dt
,main.bus_year_qtr_end_dt AS bus_year_qtr_end_dt
,main.bus_year_qtr_week_cnt AS bus_year_qtr_week_cnt
,main.bus_year_qtr_part_week_cnt AS bus_year_qtr_part_week_cnt
,main.bus_year_qtr_day_cnt AS bus_year_qtr_day_cnt
,main.prev_1y_bus_year_qtr AS prev_1y_bus_year_qtr
,main.prev_2y_bus_year_qtr AS prev_2y_bus_year_qtr
,main.prev_3y_bus_year_qtr AS prev_3y_bus_year_qtr
,main.prev_4y_bus_year_qtr AS prev_4y_bus_year_qtr
,main.prev_5y_bus_year_qtr AS prev_5y_bus_year_qtr
,main.curr_bus_year_qtr_fg AS curr_bus_year_qtr_fg
,main.bus_year_qtr_offset AS bus_year_qtr_offset
,main.bus_half_year_offset AS bus_half_year_offset
,main.bus_year_offset AS bus_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_BUSINESS_YEAR_QUARTER main 
WHERE main.bus_year_offset BETWEEN -20 AND 2 ;