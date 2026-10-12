CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_CALENDAR_HALF_YEAR_1 (
cal_half_year COMMENT 'The identifier for a calendar_1 half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.'
,cal_year COMMENT 'The calendar_1 year as a number in the form YYYY. Eg. 2019'
,cal_half_year_name COMMENT 'The text which is displayed for the calendar_1 half year in reports, in group language, i.e. German. E.g. 2021-HJ1 for the first half of the calendar_1 year 2021.'
,cal_half_year_name_de COMMENT 'The text which is displayed for the calendar_1 half year in reports, in German. E.g. 2021-HJ1 for the first half of the calendar_1 year 2021.'
,cal_half_year_name_en COMMENT 'The text which is displayed for the calendar_1 half year in reports, in English. E.g. 2021-HY1 for the first half of the calendar_1 year 2021.'
,half_of_cal_year COMMENT 'The number of the half year within the calendar_1 year. E.g. 1 for the first half year of 2021.'
,cal_half_year_begin_month COMMENT 'The first (calendar_1) month (inclusive) of the calendar_1 half year as a number in the form YYYYMM. Eg. 201901.'
,cal_half_year_end_month COMMENT 'The last (calendar_1) month (inclusive) of the calendar_1 half year as a number in the form YYYYMM. Eg. 201912.'
,cal_half_year_begin_part_week COMMENT 'The first partial week (inclusive) of the calendar_1 half year as a number in the form YYYYWWn. Eg. 2019012.'
,cal_half_year_end_part_week COMMENT 'The last partial week (inclusive) of the calendar_1 half year as a number in the form YYYYWWn. Eg. 2020011.'
,cal_half_year_begin_dt COMMENT 'The first day (inclusive) of the calendar_1 half year as a conventional calendar_1 date in the form \'YYYY-MM_1-DD\'. Eg. \'2019-01-01\'.'
,cal_half_year_end_dt COMMENT 'The first day (inclusive) of the calendar_1 half year as a conventional calendar_1 date in the form \'YYYY-MM_1-DD\'. Eg. \'2019-12-31\'. '
,cal_half_year_week_cnt COMMENT 'The number of weeks that this calendar_1 half year contains. If a week spans two half years, it is counted for the half year, in which it has at least four days.'
,cal_half_year_part_week_cnt COMMENT 'The number of partial weeks that this calendar_1 half year contains.'
,cal_half_year_day_cnt COMMENT 'The number of days that this calendar_1 half year contains.'
,prev_1y_cal_half_year COMMENT 'The calendar_1 half year one year ago as a number in the form YYYYn. Eg. 20201, if the current half year is 20211.'
,prev_2y_cal_half_year COMMENT 'The calendar_1 half year two years ago as a number in the form YYYYn. Eg. 20191, if the current half year is 20211.'
,prev_3y_cal_half_year COMMENT 'The calendar_1 half year three years ago as a number in the form YYYYn. Eg. 20181, if the current half year is 20211.'
,prev_4y_cal_half_year COMMENT 'The calendar_1 half year four years ago as a number in the form YYYYn. Eg. 20171, if the current half year is 20211.'
,prev_5y_cal_half_year COMMENT 'The calendar_1 half year five years ago as a number in the form YYYYn. Eg. 20161, if the current half year is 20211.'
,curr_cal_half_year_fg COMMENT 'This indicator is set for the current calendar_1 half year.'
,cal_half_year_offset COMMENT 'The difference in calendar_1 half years between this calendar_1 half year and the current calendar_1 half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'
,cal_year_offset COMMENT 'The difference in years between the calendar_1 year to which this half year belongs, and the current calendar_1 year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'A half year in the calendar. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.' AS SELECT
main.cal_half_year AS cal_half_year
,main.cal_year AS cal_year
,main.cal_half_year_name AS cal_half_year_name
,main.cal_half_year_name_de AS cal_half_year_name_de
,main.cal_half_year_name_en AS cal_half_year_name_en
,main.half_of_cal_year AS half_of_cal_year
,main.cal_half_year_begin_month AS cal_half_year_begin_month
,main.cal_half_year_end_month AS cal_half_year_end_month
,main.cal_half_year_begin_part_week AS cal_half_year_begin_part_week
,main.cal_half_year_end_part_week AS cal_half_year_end_part_week
,main.cal_half_year_begin_dt AS cal_half_year_begin_dt
,main.cal_half_year_end_dt AS cal_half_year_end_dt
,main.cal_half_year_week_cnt AS cal_half_year_week_cnt
,main.cal_half_year_part_week_cnt AS cal_half_year_part_week_cnt
,main.cal_half_year_day_cnt AS cal_half_year_day_cnt
,main.prev_1y_cal_half_year AS prev_1y_cal_half_year
,main.prev_2y_cal_half_year AS prev_2y_cal_half_year
,main.prev_3y_cal_half_year AS prev_3y_cal_half_year
,main.prev_4y_cal_half_year AS prev_4y_cal_half_year
,main.prev_5y_cal_half_year AS prev_5y_cal_half_year
,main.curr_cal_half_year_fg AS curr_cal_half_year_fg
,main.cal_half_year_offset AS cal_half_year_offset
,main.cal_year_offset AS cal_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_CALENDAR_HALF_YEAR_1 main 
WHERE main.cal_year_offset BETWEEN -20 AND 2 ;