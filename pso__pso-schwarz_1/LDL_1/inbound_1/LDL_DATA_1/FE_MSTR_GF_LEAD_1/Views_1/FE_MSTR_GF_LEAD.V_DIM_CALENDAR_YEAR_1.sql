CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_CALENDAR_YEAR_1 (
cal_year COMMENT 'The calendar_1 year as a number in the form YYYY. Eg. 2019'
,cal_year_begin_month COMMENT 'The first (calendar_1) month (inclusive) of the calendar_1 year as a number in the form YYYYMM. Eg. 201901.'
,cal_year_end_month COMMENT 'The last (calendar_1) month (inclusive) of the calendar_1 year as a number in the form YYYYMM. Eg. 201912.'
,cal_year_begin_part_week COMMENT 'The first partial week (inclusive) of the calendar_1 year as a number in the form YYYYWWn. Eg. 2019012.'
,cal_year_end_part_week COMMENT 'The last partial week (inclusive) of the calendar_1 year as a number in the form YYYYWWn. Eg. 2020011.'
,cal_year_begin_dt COMMENT 'The first day (inclusive) of the calendar_1 year as a conventional calendar_1 date in the form \'YYYY-MM_1-DD\'. Eg. \'2019-01-01\'.'
,cal_year_end_dt COMMENT 'The first day (inclusive) of the calendar_1 year as a conventional calendar_1 date in the form \'YYYY-MM_1-DD\'. Eg. \'2019-12-31\'. '
,cal_year_week_cnt COMMENT 'The number of weeks that this calendar_1 year contains. (i,.e. 52 or 53) If a week spans two years, it is counted for the year, in which it has at least four days.'
,cal_year_part_week_cnt COMMENT 'The number of partial weeks that this calendar_1 year contains.'
,cal_year_day_cnt COMMENT 'The number of days that this calendar_1 year contains. (i,.e. 365 or 366 for leap years)'
,leap_year_fg COMMENT 'An indicator showing, if this year is a leap year, i.e. if it has 366 days.'
,prev_1y_cal_year COMMENT 'The calendar_1 year one year ago as a number in the form YYYY. Eg. 2018, if the current year is 2019.'
,prev_2y_cal_year COMMENT 'The calendar_1 year two years ago as a number in the form YYYY. Eg. 2017, if the current year is 2019.'
,prev_3y_cal_year COMMENT 'The calendar_1 year three years ago as a number in the form YYYY. Eg. 2016, if the current year is 2019.'
,prev_4y_cal_year COMMENT 'The calendar_1 year four years ago as a number in the form YYYY. Eg. 2015, if the current year is 2019.'
,prev_5y_cal_year COMMENT 'The calendar_1 year five years ago as a number in the form YYYY. Eg. 2014, if the current year is 2019.'
,curr_cal_year_fg COMMENT 'This indicator is set for the current calendar_1 year.'
,cal_year_offset COMMENT 'The difference in years between this calendar_1 year and the current calendar_1 year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'Calendar_1 years, starting on January 1st and ending on December 31st.' AS SELECT
main.cal_year AS cal_year
,main.cal_year_begin_month AS cal_year_begin_month
,main.cal_year_end_month AS cal_year_end_month
,main.cal_year_begin_part_week AS cal_year_begin_part_week
,main.cal_year_end_part_week AS cal_year_end_part_week
,main.cal_year_begin_dt AS cal_year_begin_dt
,main.cal_year_end_dt AS cal_year_end_dt
,main.cal_year_week_cnt AS cal_year_week_cnt
,main.cal_year_part_week_cnt AS cal_year_part_week_cnt
,main.cal_year_day_cnt AS cal_year_day_cnt
,main.leap_year_fg AS leap_year_fg
,main.prev_1y_cal_year AS prev_1y_cal_year
,main.prev_2y_cal_year AS prev_2y_cal_year
,main.prev_3y_cal_year AS prev_3y_cal_year
,main.prev_4y_cal_year AS prev_4y_cal_year
,main.prev_5y_cal_year AS prev_5y_cal_year
,main.curr_cal_year_fg AS curr_cal_year_fg
,main.cal_year_offset AS cal_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_CALENDAR_YEAR_1 main 
WHERE main.cal_year_offset BETWEEN -20 AND 2 ;