create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_CALENDAR_PARTIAL_WEEK_1(
	PART_WEEK COMMENT 'The partial week as a number of the form YYYYWWn. YYYY is the calendar_1 year and WW is the number of the week within the year and n is sequence number (1 or 2) of the partial week within the week.',
	CAL_YEAR COMMENT 'The calendar_1 year to which this partial week belongs as a number in the form YYYY. Eg. 2019',
	CAL_HALF_YEAR COMMENT 'The identifier for a calendar_1 half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.',
	CAL_YEAR_QTR COMMENT 'The quarter of a calendar_1 year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.',
	BUS_YEAR COMMENT 'The business year containing the partial week as a number in the form YYYY.  ',
	BUS_HALF_YEAR COMMENT 'The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.',
	BUS_YEAR_QTR COMMENT 'The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. ',
	CAL_MONTH COMMENT 'The calendar_1 month containing the partial week as a number of the form YYYYMM, where YYYY is the calendar_1 year and MM_1 is month of the calendar_1 year.',
	CAL_WEEK COMMENT 'The week containing the partial week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the year. I.e. the week that was split to form this partial week. ',
	PART_WEEK_SHORT_NAME COMMENT 'A short version of the name, by which the partial week is referenced by business, in group language, i.e. in German, in the form \""TW WW/ n\"", where WW is the number of the week in the year, and n is the number of the partial week (1 or 2) within the week.',
	PART_WEEK_SHORT_NAME_DE COMMENT 'A short version of the name, by which the partial week is referenced by business, in German in the form \""TW WW/ n\"", where WW is the number of the week in the year, and n is the number of the partial week (1 or 2) within the week.',
	PART_WEEK_SHORT_NAME_EN COMMENT 'A short version of the name, by which the partial week is referenced by business, in English in the form \""PW WW/ n\"", where WW is the number of the week in the year, and n is the number of the partial week (1 or 2) within the week.',
	PART_WEEK_NAME COMMENT 'The name, by which the partial week is referenced by business, in group language, i.e. in German, in the form \""TW WW/ P  YYYY\"", where WW is the number of the week in the year, n is the number of the partial week (1 or 2) within the week, and YYYY is the calendar_1 year.',
	PART_WEEK_NAME_DE COMMENT 'The name, by which the partial week is referenced by business, in German in the form \""TW WW/ P  YYYY\"", where WW is the number of the week in the year, n is the number of the partial week (1 or 2) within the week, and YYYY is the calendar_1 year.',
	PART_WEEK_NAME_EN COMMENT 'The name, by which the partial week is referenced by business, in English in the form \""PW WW/ P  YYYY\"", where WW is the number of the week in the year, n is the number of the partial week (1 or 2) within the week, and YYYY is the calendar_1 year.',
	PART_WEEK_DESCR COMMENT 'A description in group language (German) of the range of weekdays, as defined by the partial week, in the format \""DD - DD\"". E.g. \""Mo - Do\"" for Monday to Thursday.',
	PART_WEEK_DESCR_DE COMMENT 'A description in German of the range of weekdays, as defined by the partial week, in the format \""DD - DD\"". E.g. \""Mo - Do\"" for Monday to Thursday.',
	PART_WEEK_DESCR_EN COMMENT 'A description in English of the range of weekdays, as defined by the partial week, in the format \""DDD - DDD\"". E.g. \""Mon - Thu\"" for Monday to Thursday.',
	WEEK_OF_CAL_YEAR COMMENT 'The number of the week within the calendar_1 year, to which this partial week belongs. A number between 1 and 53. (Week 1 is the first week of the calendar_1 year that contains at least 4 days.)',
	WEEK_OF_BUS_YEAR COMMENT 'The number of the week within the business year, i.e. a number between 1 and 53. Week 1 is the first week in the business year containing at least 4 days, therefore the first week containing a Thursday.',
	PART_WEEK_SEQ COMMENT 'The sequence number of the partial week within the week containing that partial week. (1 or 2)',
	PART_WEEK_BEGIN_DT COMMENT 'The first day (inclusive) of the partial week in the form YYYY-MM_1-DD.',
	PART_WEEK_END_DT COMMENT 'The last day (inclusive) of the partial week in the form YYYY-MM_1-DD.',
	PART_WEEK_BEGIN_DAY_OF_WEEK COMMENT 'The day of the week (number) of the first day (inclusive) of the partial week.',
	PART_WEEK_END_DAY_OF_WEEK COMMENT 'The day of the week (number) of the last day (inclusive) of the partial week.',
	PART_WEEK_FULL_WEEK_FG COMMENT 'A flag indicating whether a partial week is a full week. I.e. does the partial week contain 7 days?',
	PART_WEEK_DAY_CNT COMMENT 'The number of days that this partial week contains.',
	PREV_1Y_PART_WEEK COMMENT 'The corresponding partial week 1 year  (= 52 weeks) ago as a number in the form YYYYWWn.',
	PREV_2Y_PART_WEEK COMMENT 'The corresponding partial week 2 years (= 104 weeks) ago as a number in the form YYYYWWn.',
	PREV_3Y_PART_WEEK COMMENT 'The corresponding partial week 3 years (= 156 weeks) ago as a number in the form YYYYWWn.',
	PREV_4Y_PART_WEEK COMMENT 'The corresponding partial week 4 years (= 208 weeks) ago as a number in the form YYYYWWn.',
	PREV_5Y_PART_WEEK COMMENT 'The corresponding partial week 5 years (= 260 weeks) ago as a number in the form YYYYWWn.',
	PREV_1Y_SWDAY_PERIOD_BEGIN_DT COMMENT 'The first day of the corresponding period one year ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_1Y_SWDAY_PERIOD_END_DT COMMENT 'The last day of the corresponding period one year ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_2Y_SWDAY_PERIOD_BEGIN_DT COMMENT 'The first day of the corresponding period two years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_2Y_SWDAY_PERIOD_END_DT COMMENT 'The last day of the corresponding period two years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_3Y_SWDAY_PERIOD_BEGIN_DT COMMENT 'The first day of the corresponding period three years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_3Y_SWDAY_PERIOD_END_DT COMMENT 'The last day of the corresponding period three years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_4Y_SWDAY_PERIOD_BEGIN_DT COMMENT 'The first day of the corresponding period four years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_4Y_SWDAY_PERIOD_END_DT COMMENT 'The last day of the corresponding period four years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_5Y_SWDAY_PERIOD_BEGIN_DT COMMENT 'The first day of the corresponding period five years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	PREV_5Y_SWDAY_PERIOD_END_DT COMMENT 'The last day of the corresponding period five years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)',
	CURR_PART_WEEK_FG COMMENT 'This indicator is set for the current partial week.',
	PART_WEEK_OFFSET COMMENT 'The difference in partial weeks between this partial week and the current partial week (or week).',
	CAL_WEEK_OFFSET COMMENT 'The difference in weeks between the week to which this partial week belongs, and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101.',
	CAL_MONTH_OFFSET COMMENT 'The difference in months between the calendar_1 month to which this partial week belongs, and the current calendar_1 month. So if current calendar_1 month is 201901 then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.',
	CAL_YEAR_QTR_OFFSET COMMENT 'The difference in calendar_1 year quarters between the calendar_1 year quarter to which this partial week  belongs, and the current calendar_1 year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	CAL_HALF_YEAR_OFFSET COMMENT 'The difference in calendar_1 half years between the calendar_1 half year to which this partial week belongs, and the current calendar_1 half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	CAL_YEAR_OFFSET COMMENT 'The difference in years between the calendar_1 year to which this partial week belongs, and the current calendar_1 year. So if the current calendar_1 year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020. ',
	BUS_YEAR_QTR_OFFSET COMMENT 'The difference in business year quarters between the business year quarter to which this partial week belongs, and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	BUS_HALF_YEAR_OFFSET COMMENT 'The difference in business half years between the business half year to which this partial week belongs, and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	BUS_YEAR_OFFSET COMMENT 'The difference in years between the business year to which this partial week belongs, and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A calendar_1 week that spans two months, is split into two partial weeks.'
 as SELECT
main.part_week AS part_week
,main.cal_year AS cal_year
,main.cal_half_year AS cal_half_year
,main.cal_year_qtr AS cal_year_qtr
,main.bus_year AS bus_year
,main.bus_half_year AS bus_half_year
,main.bus_year_qtr AS bus_year_qtr
,main.cal_month AS cal_month
,main.cal_week AS cal_week
,main.part_week_short_name AS part_week_short_name
,main.part_week_short_name_de AS part_week_short_name_de
,main.part_week_short_name_en AS part_week_short_name_en
,main.part_week_name AS part_week_name
,main.part_week_name_de AS part_week_name_de
,main.part_week_name_en AS part_week_name_en
,main.part_week_descr AS part_week_descr
,main.part_week_descr_de AS part_week_descr_de
,main.part_week_descr_en AS part_week_descr_en
,main.week_of_cal_year AS week_of_cal_year
,main.week_of_bus_year AS week_of_bus_year
,main.part_week_seq AS part_week_seq
,main.part_week_begin_dt AS part_week_begin_dt
,main.part_week_end_dt AS part_week_end_dt
,main.part_week_begin_day_of_week AS part_week_begin_day_of_week
,main.part_week_end_day_of_week AS part_week_end_day_of_week
,main.part_week_full_week_fg AS part_week_full_week_fg
,main.part_week_day_cnt AS part_week_day_cnt
,main.prev_1y_part_week AS prev_1y_part_week
,main.prev_2y_part_week AS prev_2y_part_week
,main.prev_3y_part_week AS prev_3y_part_week
,main.prev_4y_part_week AS prev_4y_part_week
,main.prev_5y_part_week AS prev_5y_part_week
,main.prev_1y_swday_period_begin_dt AS prev_1y_swday_period_begin_dt
,main.prev_1y_swday_period_end_dt AS prev_1y_swday_period_end_dt
,main.prev_2y_swday_period_begin_dt AS prev_2y_swday_period_begin_dt
,main.prev_2y_swday_period_end_dt AS prev_2y_swday_period_end_dt
,main.prev_3y_swday_period_begin_dt AS prev_3y_swday_period_begin_dt
,main.prev_3y_swday_period_end_dt AS prev_3y_swday_period_end_dt
,main.prev_4y_swday_period_begin_dt AS prev_4y_swday_period_begin_dt
,main.prev_4y_swday_period_end_dt AS prev_4y_swday_period_end_dt
,main.prev_5y_swday_period_begin_dt AS prev_5y_swday_period_begin_dt
,main.prev_5y_swday_period_end_dt AS prev_5y_swday_period_end_dt
,main.curr_part_week_fg AS curr_part_week_fg
,main.part_week_offset AS part_week_offset
,main.cal_week_offset AS cal_week_offset
,main.cal_month_offset AS cal_month_offset
,main.cal_year_qtr_offset AS cal_year_qtr_offset
,main.cal_half_year_offset AS cal_half_year_offset
,main.cal_year_offset AS cal_year_offset
,main.bus_year_qtr_offset AS bus_year_qtr_offset
,main.bus_half_year_offset AS bus_half_year_offset
,main.bus_year_offset AS bus_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_CALENDAR_PARTIAL_WEEK_1 main 
WHERE main.bus_year_offset BETWEEN -20 AND 2 ;