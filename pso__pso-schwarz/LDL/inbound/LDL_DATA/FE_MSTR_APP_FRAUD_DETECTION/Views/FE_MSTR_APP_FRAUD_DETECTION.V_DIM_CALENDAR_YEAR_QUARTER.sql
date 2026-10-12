CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_CALENDAR_YEAR_QUARTER (
cal_year_qtr COMMENT 'The quarter of a calendar year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.'
,cal_year COMMENT 'The calendar year as a number in the form YYYY. Eg. 2019'
,cal_half_year COMMENT 'The identifier for a calendar half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.'
,cal_year_qtr_name COMMENT 'The text which is displayed for the quarter of the calendar year in reports, in group language, i.e. German. E.g. Q1/2021 for the first quarter of the calendar year 2021.'
,cal_year_qtr_name_de COMMENT 'The text which is displayed for the quarter of the calendar year in reports, in German. E.g. Q1/2021 for the first quarter of the calendar year 2021.'
,cal_year_qtr_name_en COMMENT 'The text which is displayed for the quarter of the calendar year in reports, in English. E.g. Q1/2021 for the first quarter of the calendar year 2021.'
,qtr_of_cal_year COMMENT 'The number of the quarter within the calendar year. E.g. 3 for Q3/2021.'
,cal_year_qtr_begin_month COMMENT 'The first (calendar) month (inclusive) of the calendar year quarter as a number in the form YYYYMM. Eg. 202101.'
,cal_year_qtr_end_month COMMENT 'The last (calendar) month (inclusive) of the calendar year quarter as a number in the form YYYYMM. Eg. 202103.'
,cal_year_qtr_begin_part_week COMMENT 'The first partial week (inclusive) of the calendar year quarter as a number in the form YYYYWWn. Eg. 2021011.'
,cal_year_qtr_end_part_week COMMENT 'The last partial week (inclusive) of the calendar year quarter as a number in the form YYYYWWn. Eg. 2021131.'
,cal_year_qtr_begin_dt COMMENT 'The first day (inclusive) of the calendar year quarter as a conventional calendar date in the form \'YYYY-MM-DD\'. Eg. \'2021-01-01\'.'
,cal_year_qtr_end_dt COMMENT 'The first day (inclusive) of the calendar year quarter as a conventional calendar date in the form \'YYYY-MM-DD\'. Eg. \'2021-03-31\'. '
,cal_year_qtr_week_cnt COMMENT 'The number of weeks that this calendar year quarter contains. If a week spans two quarters, it is counted for the quarter, in which it has at least four days.'
,cal_year_qtr_part_week_cnt COMMENT 'The number of partial weeks that this calendar year quarter contains.'
,cal_year_qtr_day_cnt COMMENT 'The number of days that this calendar year quarter contains.'
,prev_1y_cal_year_qtr COMMENT 'The calendar year quarter one year ago as a number in the form YYYYn. Eg. 20201, if the current quarter is 20211.'
,prev_2y_cal_year_qtr COMMENT 'The calendar year quarter two years ago as a number in the form YYYYn. Eg. 20191, if the current quarter is 20211.'
,prev_3y_cal_year_qtr COMMENT 'The calendar year quarter three years ago as a number in the form YYYYn. Eg. 20181, if the current quarter is 20211.'
,prev_4y_cal_year_qtr COMMENT 'The calendar year quarter four years ago as a number in the form YYYYn. Eg. 20171, if the current quarter is 20211.'
,prev_5y_cal_year_qtr COMMENT 'The calendar year quarter five years ago as a number in the form YYYYn. Eg. 20161, if the current quarter is 20211.'
,curr_cal_year_qtr_fg COMMENT 'This indicator is set for the current quarter of the calendar year.'
,cal_year_qtr_offset COMMENT 'The difference in calendar year quarters between this calendar year quarter and the current calendar year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'
,cal_half_year_offset COMMENT 'The difference in calendar half years between the calendar half year to which this quarter belongs, and the current calendar half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'
,cal_year_offset COMMENT 'The difference in years between the calendar year to which this quarter belongs, and the current calendar year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'The quarter of a calendar year, e.g. Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.' AS SELECT
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
FROM CORE_DIM.T_DIM_CALENDAR_YEAR_QUARTER main 
WHERE main.cal_year_offset BETWEEN -20 AND 2 ;