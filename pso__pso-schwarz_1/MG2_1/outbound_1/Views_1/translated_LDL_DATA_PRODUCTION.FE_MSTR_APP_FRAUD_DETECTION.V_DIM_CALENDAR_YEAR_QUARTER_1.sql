CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_calendar_year_quarter_1 (cal_year_qtr
OPTIONS(description='The quarter of a calendar_1 year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.'),
cal_year OPTIONS(description='The calendar_1 year as a number in the form YYYY. Eg. 2019'), cal_half_year
OPTIONS(description='The identifier for a calendar_1 half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.'),
cal_year_qtr_name
OPTIONS(description='The text which is displayed for the quarter of the calendar_1 year in reports, in group language, i.e. German. E.g. Q1/2021 for the first quarter of the calendar_1 year 2021.'),
cal_year_qtr_name_de
OPTIONS(description='The text which is displayed for the quarter of the calendar_1 year in reports, in German. E.g. Q1/2021 for the first quarter of the calendar_1 year 2021.'),
cal_year_qtr_name_en
OPTIONS(description='The text which is displayed for the quarter of the calendar_1 year in reports, in English. E.g. Q1/2021 for the first quarter of the calendar_1 year 2021.'),
qtr_of_cal_year OPTIONS(description='The number of the quarter within the calendar_1 year. E.g. 3 for Q3/2021.'),
cal_year_qtr_begin_month
OPTIONS(description='The first (calendar_1) month (inclusive) of the calendar_1 year quarter as a number in the form YYYYMM. Eg. 202101.'),
cal_year_qtr_end_month
OPTIONS(description='The last (calendar_1) month (inclusive) of the calendar_1 year quarter as a number in the form YYYYMM. Eg. 202103.'),
cal_year_qtr_begin_part_week
OPTIONS(description='The first partial week (inclusive) of the calendar_1 year quarter as a number in the form YYYYWWn. Eg. 2021011.'),
cal_year_qtr_end_part_week
OPTIONS(description='The last partial week (inclusive) of the calendar_1 year quarter as a number in the form YYYYWWn. Eg. 2021131.'),
cal_year_qtr_begin_dt
OPTIONS(description='The first day (inclusive) of the calendar_1 year quarter as a conventional calendar_1 date in the form "YYYY-MM_1-DD". Eg. "2021-01-01".'),
cal_year_qtr_end_dt
OPTIONS(description='The first day (inclusive) of the calendar_1 year quarter as a conventional calendar_1 date in the form "YYYY-MM_1-DD". Eg. "2021-03-31". '),
cal_year_qtr_week_cnt
OPTIONS(description='The number of weeks that this calendar_1 year quarter contains. If a week spans two quarters, it is counted for the quarter, in which it has at least four days.'),
cal_year_qtr_part_week_cnt OPTIONS(description='The number of partial weeks that this calendar_1 year quarter contains.'),
cal_year_qtr_day_cnt OPTIONS(description='The number of days that this calendar_1 year quarter contains.'),
prev_1y_cal_year_qtr
OPTIONS(description='The calendar_1 year quarter one year ago as a number in the form YYYYn. Eg. 20201, if the current quarter is 20211.'),
prev_2y_cal_year_qtr
OPTIONS(description='The calendar_1 year quarter two years ago as a number in the form YYYYn. Eg. 20191, if the current quarter is 20211.'),
prev_3y_cal_year_qtr
OPTIONS(description='The calendar_1 year quarter three years ago as a number in the form YYYYn. Eg. 20181, if the current quarter is 20211.'),
prev_4y_cal_year_qtr
OPTIONS(description='The calendar_1 year quarter four years ago as a number in the form YYYYn. Eg. 20171, if the current quarter is 20211.'),
prev_5y_cal_year_qtr
OPTIONS(description='The calendar_1 year quarter five years ago as a number in the form YYYYn. Eg. 20161, if the current quarter is 20211.'),
curr_cal_year_qtr_fg OPTIONS(description='This indicator is set for the current quarter of the calendar_1 year.'),
cal_year_qtr_offset
OPTIONS(description='The difference in calendar_1 year quarters between this calendar_1 year quarter and the current calendar_1 year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'),
cal_half_year_offset
OPTIONS(description='The difference in calendar_1 half years between the calendar_1 half year to which this quarter belongs, and the current calendar_1 half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
cal_year_offset
OPTIONS(description='The difference in years between the calendar_1 year to which this quarter belongs, and the current calendar_1 year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE QUARTER OF A CALENDAR_1 YEAR, E.G. Q1/2021 STARTING ON JANUARY 1ST 2021 AND ENDING ON MARCH 31ST 2021.`)
AS SELECT cal_year_qtr,
 cal_year,
 cal_half_year,
 cal_year_qtr_name,
 cal_year_qtr_name_de,
 cal_year_qtr_name_en,
 qtr_of_cal_year,
 cal_year_qtr_begin_month,
 cal_year_qtr_end_month,
 cal_year_qtr_begin_part_week,
 cal_year_qtr_end_part_week,
 cal_year_qtr_begin_dt,
 cal_year_qtr_end_dt,
 cal_year_qtr_week_cnt,
 cal_year_qtr_part_week_cnt,
 cal_year_qtr_day_cnt,
 prev_1y_cal_year_qtr,
 prev_2y_cal_year_qtr,
 prev_3y_cal_year_qtr,
 prev_4y_cal_year_qtr,
 prev_5y_cal_year_qtr,
 curr_cal_year_qtr_fg,
 cal_year_qtr_offset,
 cal_half_year_offset,
 cal_year_offset,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_calendar_year_quarter_1 AS main
WHERE cal_year_offset BETWEEN - 20 AND 2;