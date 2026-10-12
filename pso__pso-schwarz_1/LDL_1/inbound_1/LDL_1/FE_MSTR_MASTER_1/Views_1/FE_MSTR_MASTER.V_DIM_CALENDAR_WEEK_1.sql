CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_CALENDAR_WEEK_1 (
cal_week COMMENT 'The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.'
,week_of_cal_year COMMENT 'The number of the week within the calendar_1 year, i.e. a number between 1 and 53. Week 1 is the first week in the calendar_1 year containing at least 4 days, therefore the first week containing a Thursday.'
,week_of_bus_year COMMENT 'The number of the week within the business year, i.e. a number between 1 and 53. Week 1 is the first week in the business year containing at least 4 days, therefore the first week containing a Thursday.'
,cal_week_short_name COMMENT 'A short version of the name of the week in group language, i.e. in German, in the format "KW nn" with nn being the week of the year.'
,cal_week_short_name_de COMMENT 'A short version of the name of the week in German in the format "KW nn" with nn being the week of the year.'
,cal_week_short_name_en COMMENT 'A short version of the name of the week in English in the format "week nn" with nn being the week of the year.'
,cal_week_name COMMENT 'The name of the week in group language, i.e. in German, in the format "YYYY KW nn" with YYYY being the year and nn being the week of the year.'
,cal_week_name_de COMMENT 'The name of the week in German in the format "YYYY KW nn" with YYYY being the year and nn being the week of the year.'
,cal_week_name_en COMMENT 'The name of the week in English in the format "YYYY week nn" with YYYY being the year and nn being the week of the year.'
,cal_week_begin_part_week COMMENT 'The first partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020531.'
,cal_week_end_part_week COMMENT 'The last partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020532. If the week does not span two months, this is the same as cy_week_begin_week_part.'
,cal_week_begin_dt COMMENT 'The first day of the week - i.e. the Monday - in the form YYYY-MM_1-DD. Eg. 2020-12-28.'
,cal_week_end_dt COMMENT 'The last day of the week - i.e. the Sunday - in the form YYYY-MM_1-DD. Eg. 2021-01-03. '
,cal_week_part_week_cnt COMMENT 'The number of partial weeks in this week, i.e. 1 or 2.'
,prev_1w_cal_week COMMENT 'The previous week as a number in the form YYYYWW. Eg. 202052. '
,prev_1y1w_cal_week COMMENT 'The week 1 year and 1 week (= 371 days = 53 weeks) ago as a number in the form YYYYWW. Eg. 202001.'
,prev_1y_cal_week COMMENT 'The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.'
,prev_2y_cal_week COMMENT 'The week 2 years (= 728 days = 104 weeks) ago as a number in the form YYYYWW. Eg. 201901. '
,prev_3y_cal_week COMMENT 'The week 3 years (= 1092 days = 156 weeks) ago as a number in the form YYYYWW. Eg. 201801.'
,prev_4y_cal_week COMMENT 'The week 4 years (= 1456 days = 208 weeks) ago as a number in the form YYYYWW. Eg. 201701.'
,prev_5y_cal_week COMMENT 'The week 5 years (= 1820 days = 260 weeks) ago as a number in the form YYYYWW. Eg. 201601.'
,curr_cal_week_fg COMMENT 'This indicator is set for the current calendar_1 week.'
,cal_week_offset COMMENT 'The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101. '
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'Calendar_1 weeks. A week may span two months or two years. A week is considered part of the year, into which most of its days fall.' AS SELECT
main.cal_week AS cal_week
,main.week_of_cal_year AS week_of_cal_year
,main.week_of_bus_year AS week_of_bus_year
,main.cal_week_short_name AS cal_week_short_name
,main.cal_week_short_name_de AS cal_week_short_name_de
,main.cal_week_short_name_en AS cal_week_short_name_en
,main.cal_week_name AS cal_week_name
,main.cal_week_name_de AS cal_week_name_de
,main.cal_week_name_en AS cal_week_name_en
,main.cal_week_begin_part_week AS cal_week_begin_part_week
,main.cal_week_end_part_week AS cal_week_end_part_week
,main.cal_week_begin_dt AS cal_week_begin_dt
,main.cal_week_end_dt AS cal_week_end_dt
,main.cal_week_part_week_cnt AS cal_week_part_week_cnt
,main.prev_1w_cal_week AS prev_1w_cal_week
,main.prev_1y1w_cal_week AS prev_1y1w_cal_week
,main.prev_1y_cal_week AS prev_1y_cal_week
,main.prev_2y_cal_week AS prev_2y_cal_week
,main.prev_3y_cal_week AS prev_3y_cal_week
,main.prev_4y_cal_week AS prev_4y_cal_week
,main.prev_5y_cal_week AS prev_5y_cal_week
,main.curr_cal_week_fg AS curr_cal_week_fg
,main.cal_week_offset AS cal_week_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_CALENDAR_WEEK_1 main ;