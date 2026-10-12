CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_calendar_week_1 (cal_week
OPTIONS(description='The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.'),
week_of_cal_year
OPTIONS(description='The number of the week within the calendar_1 year, i.e. a number between 1 and 53. Week 1 is the first week in the calendar_1 year containing at least 4 days, therefore the first week containing a Thursday.'),
week_of_bus_year
OPTIONS(description='The number of the week within the business year, i.e. a number between 1 and 53. Week 1 is the first week in the business year containing at least 4 days, therefore the first week containing a Thursday.'),
cal_week_short_name
OPTIONS(description='A short version of the name of the week in group language, i.e. in German, in the format "KW nn" with nn being the week of the year.'),
cal_week_short_name_de
OPTIONS(description='A short version of the name of the week in German in the format "KW nn" with nn being the week of the year.'),
cal_week_short_name_en
OPTIONS(description='A short version of the name of the week in English in the format "week nn" with nn being the week of the year.'),
cal_week_name
OPTIONS(description='The name of the week in group language, i.e. in German, in the format "YYYY KW nn" with YYYY being the year and nn being the week of the year.'),
cal_week_name_de
OPTIONS(description='The name of the week in German in the format "YYYY KW nn" with YYYY being the year and nn being the week of the year.'),
cal_week_name_en
OPTIONS(description='The name of the week in English in the format "YYYY week nn" with YYYY being the year and nn being the week of the year.'),
cal_week_begin_part_week
OPTIONS(description='The first partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020531.'),
cal_week_end_part_week
OPTIONS(description='The last partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020532. If the week does not span two months, this is the same as cy_week_begin_week_part.'),
cal_week_begin_dt
OPTIONS(description='The first day of the week - i.e. the Monday - in the form YYYY-MM_1-DD. Eg. 2020-12-28.'),
cal_week_end_dt
OPTIONS(description='The last day of the week - i.e. the Sunday - in the form YYYY-MM_1-DD. Eg. 2021-01-03. '),
cal_week_part_week_cnt OPTIONS(description='The number of partial weeks in this week, i.e. 1 or 2.'), prev_1w_cal_week
OPTIONS(description='The previous week as a number in the form YYYYWW. Eg. 202052. '), prev_1y1w_cal_week
OPTIONS(description='The week 1 year and 1 week (= 371 days = 53 weeks) ago as a number in the form YYYYWW. Eg. 202001.'),
prev_1y_cal_week
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.'),
prev_2y_cal_week
OPTIONS(description='The week 2 years (= 728 days = 104 weeks) ago as a number in the form YYYYWW. Eg. 201901. '),
prev_3y_cal_week
OPTIONS(description='The week 3 years (= 1092 days = 156 weeks) ago as a number in the form YYYYWW. Eg. 201801.'),
prev_4y_cal_week
OPTIONS(description='The week 4 years (= 1456 days = 208 weeks) ago as a number in the form YYYYWW. Eg. 201701.'),
prev_5y_cal_week
OPTIONS(description='The week 5 years (= 1820 days = 260 weeks) ago as a number in the form YYYYWW. Eg. 201601.'),
curr_cal_week_fg OPTIONS(description='This indicator is set for the current calendar_1 week.'), cal_week_offset
OPTIONS(description='The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101. '),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `CALENDAR_1 WEEKS. A WEEK MAY SPAN TWO MONTHS OR TWO YEARS. A WEEK IS CONSIDERED PART OF THE YEAR, INTO WHICH MOST OF ITS DAYS FALL.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_calendar_week_1 AS MAIN;