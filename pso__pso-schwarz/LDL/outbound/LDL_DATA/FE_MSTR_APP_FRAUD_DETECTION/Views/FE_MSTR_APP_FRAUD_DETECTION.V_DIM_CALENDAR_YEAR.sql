CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_calendar_year (cal_year
OPTIONS(description='The calendar year as a number in the form YYYY. Eg. 2019'), cal_year_begin_month
OPTIONS(description='The first (calendar) month (inclusive) of the calendar year as a number in the form YYYYMM. Eg. 201901.'),
cal_year_end_month
OPTIONS(description='The last (calendar) month (inclusive) of the calendar year as a number in the form YYYYMM. Eg. 201912.'),
cal_year_begin_part_week
OPTIONS(description='The first partial week (inclusive) of the calendar year as a number in the form YYYYWWn. Eg. 2019012.'),
cal_year_end_part_week
OPTIONS(description='The last partial week (inclusive) of the calendar year as a number in the form YYYYWWn. Eg. 2020011.'),
cal_year_begin_dt
OPTIONS(description='The first day (inclusive) of the calendar year as a conventional calendar date in the form\'YYYY-MM-DD\'. Eg.\'2019-01-01\'.'),
cal_year_end_dt
OPTIONS(description='The first day (inclusive) of the calendar year as a conventional calendar date in the form\'YYYY-MM-DD\'. Eg.\'2019-12-31\'. '),
cal_year_week_cnt
OPTIONS(description='The number of weeks that this calendar year contains. (i,.e. 52 or 53) If a week spans two years, it is counted for the year, in which it has at least four days.'),
cal_year_part_week_cnt OPTIONS(description='The number of partial weeks that this calendar year contains.'),
cal_year_day_cnt
OPTIONS(description='The number of days that this calendar year contains. (i,.e. 365 or 366 for leap years)'),
leap_year_fg OPTIONS(description='An indicator showing, if this year is a leap year, i.e. if it has 366 days.'),
prev_1y_cal_year
OPTIONS(description='The calendar year one year ago as a number in the form YYYY. Eg. 2018, if the current year is 2019.'),
prev_2y_cal_year
OPTIONS(description='The calendar year two years ago as a number in the form YYYY. Eg. 2017, if the current year is 2019.'),
prev_3y_cal_year
OPTIONS(description='The calendar year three years ago as a number in the form YYYY. Eg. 2016, if the current year is 2019.'),
prev_4y_cal_year
OPTIONS(description='The calendar year four years ago as a number in the form YYYY. Eg. 2015, if the current year is 2019.'),
prev_5y_cal_year
OPTIONS(description='The calendar year five years ago as a number in the form YYYY. Eg. 2014, if the current year is 2019.'),
curr_cal_year_fg OPTIONS(description='This indicator is set for the current calendar year.'), cal_year_offset
OPTIONS(description='The difference in years between this calendar year and the current calendar year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `CALENDAR YEARS, STARTING ON JANUARY 1ST AND ENDING ON DECEMBER 31ST.`) AS SELECT *
FROM ldl_data_core_dim.t_dim_calendar_year AS MAIN
WHERE cal_year_offset BETWEEN - 20 AND 2;