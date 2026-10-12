create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_CALENDAR_WEEK(
	CAL_WEEK COMMENT 'The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.',
	WEEK_OF_CAL_YEAR COMMENT 'The number of the week within the calendar year, i.e. a number between 1 and 53. Week 1 is the first week in the calendar year containing at least 4 days, therefore the first week containing a Thursday.',
	WEEK_OF_BUS_YEAR COMMENT 'The number of the week within the business year, i.e. a number between 1 and 53. Week 1 is the first week in the business year containing at least 4 days, therefore the first week containing a Thursday.',
	CAL_WEEK_SHORT_NAME COMMENT 'A short version of the name of the week in group language, i.e. in German, in the format \""KW nn\"" with nn being the week of the year.',
	CAL_WEEK_SHORT_NAME_DE COMMENT 'A short version of the name of the week in German in the format \""KW nn\"" with nn being the week of the year.',
	CAL_WEEK_SHORT_NAME_EN COMMENT 'A short version of the name of the week in English in the format \""week nn\"" with nn being the week of the year.',
	CAL_WEEK_NAME COMMENT 'The name of the week in group language, i.e. in German, in the format \""YYYY KW nn\"" with YYYY being the year and nn being the week of the year.',
	CAL_WEEK_NAME_DE COMMENT 'The name of the week in German in the format \""YYYY KW nn\"" with YYYY being the year and nn being the week of the year.',
	CAL_WEEK_NAME_EN COMMENT 'The name of the week in English in the format \""YYYY week nn\"" with YYYY being the year and nn being the week of the year.',
	CAL_WEEK_BEGIN_PART_WEEK COMMENT 'The first partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020531.',
	CAL_WEEK_END_PART_WEEK COMMENT 'The last partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020532. If the week does not span two months, this is the same as cy_week_begin_week_part.',
	CAL_WEEK_BEGIN_DT COMMENT 'The first day of the week - i.e. the Monday - in the form YYYY-MM-DD. Eg. 2020-12-28.',
	CAL_WEEK_END_DT COMMENT 'The last day of the week - i.e. the Sunday - in the form YYYY-MM-DD. Eg. 2021-01-03. ',
	CAL_WEEK_PART_WEEK_CNT COMMENT 'The number of partial weeks in this week, i.e. 1 or 2.',
	PREV_1W_CAL_WEEK COMMENT 'The previous week as a number in the form YYYYWW. Eg. 202052. ',
	PREV_1Y1W_CAL_WEEK COMMENT 'The week 1 year and 1 week (= 371 days = 53 weeks) ago as a number in the form YYYYWW. Eg. 202001.',
	PREV_1Y_CAL_WEEK COMMENT 'The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.',
	PREV_2Y_CAL_WEEK COMMENT 'The week 2 years (= 728 days = 104 weeks) ago as a number in the form YYYYWW. Eg. 201901. ',
	PREV_3Y_CAL_WEEK COMMENT 'The week 3 years (= 1092 days = 156 weeks) ago as a number in the form YYYYWW. Eg. 201801.',
	PREV_4Y_CAL_WEEK COMMENT 'The week 4 years (= 1456 days = 208 weeks) ago as a number in the form YYYYWW. Eg. 201701.',
	PREV_5Y_CAL_WEEK COMMENT 'The week 5 years (= 1820 days = 260 weeks) ago as a number in the form YYYYWW. Eg. 201601.',
	CURR_CAL_WEEK_FG COMMENT 'This indicator is set for the current calendar week.',
	CAL_WEEK_OFFSET COMMENT 'The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101. ',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Calendar weeks. A week may span two months or two years. A week is considered part of the year, into which most of its days fall.'
 as SELECT
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
FROM CORE_DIM.T_DIM_CALENDAR_WEEK main ;