create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_CALENDAR_DATE_1(
	CAL_DT COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	CAL_YEAR COMMENT 'The calendar_1 year as a number in the form YYYY. Eg. 2019',
	CAL_HALF_YEAR COMMENT 'The identifier for a calendar_1 half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.',
	CAL_YEAR_QTR COMMENT 'The quarter of a calendar_1 year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.',
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
	BUS_HALF_YEAR COMMENT 'The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.',
	BUS_YEAR_QTR COMMENT 'The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. ',
	CAL_MONTH COMMENT 'The calendar_1 month as a number of the form YYYYMM, where YYYY is the calendar_1 year and MM_1 is month of the calendar_1 year.',
	CAL_MONTH_SHORT_NAME COMMENT 'The short name of the calendar_1 month in group language, i.e. in German. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name.)',
	CAL_MONTH_SHORT_NAME_DE COMMENT 'The short name of the calendar_1 month in German. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name_de.)',
	CAL_MONTH_SHORT_NAME_EN COMMENT 'The short name of the calendar_1 month English. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name_en.)',
	CAL_MONTH_NAME COMMENT 'The name of the calendar_1 month in group language, i.e. in German. E.g. Juni 2022 (This is the concatenation of cal_year and month_of_year_name.)',
	CAL_MONTH_NAME_DE COMMENT 'The name of the calendar_1 month in German. E.g. Juni 2022 (This is the concatenation of cal_year and month_of_year_name_de.)',
	CAL_MONTH_NAME_EN COMMENT 'The name of the calendar_1 month English. E.g. June 2022 (This is the concatenation of cal_year and month_of_year_name_en.)',
	MONTH_OF_CAL_YEAR COMMENT 'The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.',
	MONTH_OF_BUS_YEAR COMMENT 'The month of the business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
	MONTH_OF_YEAR_SHORT_NAME COMMENT 'The short name / abbreviation for month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_SHORT_NAME_DE COMMENT 'The short name / abbreviation for month of the year in German.',
	MONTH_OF_YEAR_SHORT_NAME_EN COMMENT 'The short name / abbreviation for month of the year in English',
	MONTH_OF_YEAR_NAME COMMENT 'The full name for the month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_NAME_DE COMMENT 'The full name for the month of the year in German.',
	MONTH_OF_YEAR_NAME_EN COMMENT 'The full name for the month of the year in English.',
	DAY_OF_MONTH COMMENT 'The sequence number of the day within the month. Simply the calendar_1 day number in the calendar_1 month. A number between 1 and 31.   ',
	CAL_WEEK COMMENT 'The week to which this week belongs, as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.',
	WEEK_OF_CAL_YEAR COMMENT 'The number of the week within the calendar_1 year, to which this day belongs., i.e. a number between 1 and 53. Week 1 is the first week in the calendar_1 year containing at least 4 days, therefore the first week containing a Thursday.',
	WEEK_OF_BUS_YEAR COMMENT 'The number of the week within the business year, to which this day belongs., i.e. a number between 1 and 53. Week 1 is the first week in the business year containing at least 4 days, therefore the first week containing a Thursday.',
	PART_WEEK COMMENT 'The partial week, to which this day belongs, as a number of the form YYYYWWn. YYYY is the calendar_1 year and WW is the number of the week within the year and n is sequence number (1 or 2) of the partial week within the week.',
	PART_WEEK_SEQ COMMENT 'The sequence number of the partial week, to which this day belongs, within the week, that contains that partial week. (1 or 2)',
	DAY_OF_WEEK COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	DAY_OF_WEEK_SHORT_NAME COMMENT 'The abbreviation for the weekday in group language, i.e. in German, ',
	DAY_OF_WEEK_SHORT_NAME_DE COMMENT 'The abbreviation for the weekday in German, ',
	DAY_OF_WEEK_SHORT_NAME_EN COMMENT 'The abbreviation for the weekday in English',
	DAY_OF_WEEK_NAME COMMENT 'The full name for day of the week in group language, i.e. in German.',
	DAY_OF_WEEK_NAME_DE COMMENT 'The full name for day of the week in German.',
	DAY_OF_WEEK_NAME_EN COMMENT 'The full name for day of the week in English',
	DAY_OF_CAL_YEAR COMMENT 'The sequence number of the day within in the calendar_1 year. A number between 1 and 366. January 1st will always be 1 and December 31st always 365 or 366 for leap years.',
	DAY_OF_BUS_YEAR COMMENT 'The sequence number of the day within in the business year. A number between 1 and 366. March 1st will always be 1, February 28th always 365 and February 29th always 366.',
	PREV_1D_CAL_DT COMMENT 'The calendar_1 date of the same day 1 day ago,',
	PREV_1W_CAL_DT COMMENT 'The calendar_1 date of the same day 1 week ago, ',
	PREV_1M_CAL_DT COMMENT 'The calendar_1 date of the same day 1 month ago. Calculated by offsetting cal_dt by -1 month. If the corresponding day does not exist in the target month then Null is returned. ',
	PREV_1Y_CAL_DT COMMENT 'The calendar_1 date of the same day 1 year ago. Calculated by subtracting 12 months. If there are insufficient days in the target month, the last day in the month is returned.',
	PREV_2Y_CAL_DT COMMENT 'The calendar_1 date of the same day 2 years ago. Calculated by subtracting 24 months. If there are insufficient days in the target month the last day in the month is returned. ',
	PREV_3Y_CAL_DT COMMENT 'The calendar_1 date of the same day 3 years ago. Calculated by subtracting 36 months. If there are insufficient days in the target month the last day in the month is returned.',
	PREV_4Y_CAL_DT COMMENT 'The calendar_1 date of the same day 4 years ago. Calculated by subtracting 48 months. If there are insufficient days in the target month the last day in the month is returned. ',
	PREV_5Y_CAL_DT COMMENT 'The calendar_1 date of the same day 5 years ago. Calculated by subtracting 60 months. If there are insufficient days in the target month the last day in the month is returned.',
	PREV_1M_SWDAY_CAL_DT COMMENT 'The calendar_1 date of the same weekday (approximately) 1 month ago. Calculated by offsetting cal_dt by -28 (days) i.e. 4 weeks. ',
	PREV_1Y_SWDAY_CAL_DT COMMENT 'The calendar_1 date of the same weekday (approximately) 1 year ago.  Calculated by offsetting cal_dt by -364 (days) ie. 52 weeks. ',
	PREV_2Y_SWDAY_CAL_DT COMMENT 'The calendar_1 date of the same weekday (approximately) 2 years ago. Calculated by offsetting cal_dt by -728 (days) i.e. 104 weeks. ',
	PREV_3Y_SWDAY_CAL_DT COMMENT 'The calendar_1 date of the same weekday (approximately) 3 years ago. Calculated by offsetting cal_dt by -1092 (days) i.e. 156 weeks. ',
	PREV_4Y_SWDAY_CAL_DT COMMENT 'The calendar_1 date of the same weekday (approximately) 4 years ago. Calculated by offsetting cal_dt by -1456 (days) i.e. 208 weeks. ',
	PREV_5Y_SWDAY_CAL_DT COMMENT 'The calendar_1 date of the same weekday (approximately) 5 years ago. Calculated by offsetting cal_dt by -1820 (days) i.e. 260 weeks. ',
	FIRST_DAY_OF_PART_WEEK_FG COMMENT 'An indicator showing, if this is the first day of the containing partial week.',
	LAST_DAY_OF_PART_WEEK_FG COMMENT 'An indicator showing, if this is the last day of the containing partial week.',
	FIRST_DAY_OF_WEEK_FG COMMENT 'An indicator showing, if this is the first day of the containing week.',
	LAST_DAY_OF_WEEK_FG COMMENT 'An indicator showing, if this is the last day of the containing week.',
	FIRST_DAY_OF_MONTH_FG COMMENT 'An indicator showing, if this is the first day of the containing month.',
	LAST_DAY_OF_MONTH_FG COMMENT 'An indicator showing, if this is the last day of the containing month.',
	FIRST_DAY_OF_CAL_YEAR_QTR_FG COMMENT 'An indicator showing, if this is the first day of the containing calendar_1 year quarter.',
	LAST_DAY_OF_CAL_YEAR_QTR_FG COMMENT 'An indicator showing, if this is the last day of the containing calendar_1 year quarter.',
	FIRST_DAY_OF_CAL_HALF_YEAR_FG COMMENT 'An indicator showing, if this is the first day of the containing calendar_1 half year.',
	LAST_DAY_OF_CAL_HALF_YEAR_FG COMMENT 'An indicator showing, if this is the last day of the containing calendar_1 half year.',
	FIRST_DAY_OF_CAL_YEAR_FG COMMENT 'An indicator showing, if this is the first day of the containing calendar_1 year.',
	LAST_DAY_OF_CAL_YEAR_FG COMMENT 'An indicator showing, if this is the last day of the containing calendar_1 year.',
	FIRST_DAY_OF_BUS_YEAR_QTR_FG COMMENT 'An indicator showing, if this is the first day of the containing business year quarter.',
	LAST_DAY_OF_BUS_YEAR_QTR_FG COMMENT 'An indicator showing, if this is the last day of the containing business year quarter.',
	FIRST_DAY_OF_BUS_HALF_YEAR_FG COMMENT 'An indicator showing, if this is the first day of the containing business half year.',
	LAST_DAY_OF_BUS_HALF_YEAR_FG COMMENT 'An indicator showing, if this is the last day of the containing business half year.',
	FIRST_DAY_OF_BUS_YEAR_FG COMMENT 'An indicator showing, if this is the first day of the containing business year.',
	LAST_DAY_OF_BUS_YEAR_FG COMMENT 'An indicator showing, if this is the last day of the containing business year.',
	CURR_CAL_DT_FG COMMENT 'This indicator is set for the current date, i.e. for the last day for which data has been loaded in the data warehouse, typically yesterday.',
	CAL_DT_OFFSET COMMENT 'The difference in days between this day and the current date. So if the current date is 2019-05-02, then this offset is 0 for 2019-05-02, -1 for 2019-05-01 and +1 for 2019-05-03.',
	PART_WEEK_OFFSET COMMENT 'The difference in partial weeks between this partial week and the current partial week (or week).',
	CAL_WEEK_OFFSET COMMENT 'The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101.  ',
	CAL_MONTH_OFFSET COMMENT 'The difference in months between this calendar_1 month and the current calendar_1 month. So if current calendar_1 month is 201901 then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.',
	CAL_YEAR_QTR_OFFSET COMMENT 'The difference in calendar_1 year quarters between this calendar_1 year quarter and the current calendar_1 year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	CAL_HALF_YEAR_OFFSET COMMENT 'The difference in calendar_1 half years between this calendar_1 half year and the current calendar_1 half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	CAL_YEAR_OFFSET COMMENT 'The difference in years between this calendar_1 year and the current calendar_1 year. So if the current calendar_1 year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	BUS_YEAR_QTR_OFFSET COMMENT 'The difference in business year quarters between this business year quarter and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	BUS_HALF_YEAR_OFFSET COMMENT 'The difference in business half years between this business half year and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	BUS_YEAR_OFFSET COMMENT 'The difference in years between this business year and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020. ',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The main time dimension for all days in the calendar.'
 as SELECT
main.cal_dt AS cal_dt
,main.cal_year AS cal_year
,main.cal_half_year AS cal_half_year
,main.cal_year_qtr AS cal_year_qtr
,main.bus_year AS bus_year
,main.bus_half_year AS bus_half_year
,main.bus_year_qtr AS bus_year_qtr
,main.cal_month AS cal_month
,main.cal_month_short_name AS cal_month_short_name
,main.cal_month_short_name_de AS cal_month_short_name_de
,main.cal_month_short_name_en AS cal_month_short_name_en
,main.cal_month_name AS cal_month_name
,main.cal_month_name_de AS cal_month_name_de
,main.cal_month_name_en AS cal_month_name_en
,main.month_of_cal_year AS month_of_cal_year
,main.month_of_bus_year AS month_of_bus_year
,main.month_of_year_short_name AS month_of_year_short_name
,main.month_of_year_short_name_de AS month_of_year_short_name_de
,main.month_of_year_short_name_en AS month_of_year_short_name_en
,main.month_of_year_name AS month_of_year_name
,main.month_of_year_name_de AS month_of_year_name_de
,main.month_of_year_name_en AS month_of_year_name_en
,main.day_of_month AS day_of_month
,main.cal_week AS cal_week
,main.week_of_cal_year AS week_of_cal_year
,main.week_of_bus_year AS week_of_bus_year
,main.part_week AS part_week
,main.part_week_seq AS part_week_seq
,main.day_of_week AS day_of_week
,main.day_of_week_short_name AS day_of_week_short_name
,main.day_of_week_short_name_de AS day_of_week_short_name_de
,main.day_of_week_short_name_en AS day_of_week_short_name_en
,main.day_of_week_name AS day_of_week_name
,main.day_of_week_name_de AS day_of_week_name_de
,main.day_of_week_name_en AS day_of_week_name_en
,main.day_of_cal_year AS day_of_cal_year
,main.day_of_bus_year AS day_of_bus_year
,main.prev_1d_cal_dt AS prev_1d_cal_dt
,main.prev_1w_cal_dt AS prev_1w_cal_dt
,main.prev_1m_cal_dt AS prev_1m_cal_dt
,main.prev_1y_cal_dt AS prev_1y_cal_dt
,main.prev_2y_cal_dt AS prev_2y_cal_dt
,main.prev_3y_cal_dt AS prev_3y_cal_dt
,main.prev_4y_cal_dt AS prev_4y_cal_dt
,main.prev_5y_cal_dt AS prev_5y_cal_dt
,main.prev_1m_swday_cal_dt AS prev_1m_swday_cal_dt
,main.prev_1y_swday_cal_dt AS prev_1y_swday_cal_dt
,main.prev_2y_swday_cal_dt AS prev_2y_swday_cal_dt
,main.prev_3y_swday_cal_dt AS prev_3y_swday_cal_dt
,main.prev_4y_swday_cal_dt AS prev_4y_swday_cal_dt
,main.prev_5y_swday_cal_dt AS prev_5y_swday_cal_dt
,main.first_day_of_part_week_fg AS first_day_of_part_week_fg
,main.last_day_of_part_week_fg AS last_day_of_part_week_fg
,main.first_day_of_week_fg AS first_day_of_week_fg
,main.last_day_of_week_fg AS last_day_of_week_fg
,main.first_day_of_month_fg AS first_day_of_month_fg
,main.last_day_of_month_fg AS last_day_of_month_fg
,main.first_day_of_cal_year_qtr_fg AS first_day_of_cal_year_qtr_fg
,main.last_day_of_cal_year_qtr_fg AS last_day_of_cal_year_qtr_fg
,main.first_day_of_cal_half_year_fg AS first_day_of_cal_half_year_fg
,main.last_day_of_cal_half_year_fg AS last_day_of_cal_half_year_fg
,main.first_day_of_cal_year_fg AS first_day_of_cal_year_fg
,main.last_day_of_cal_year_fg AS last_day_of_cal_year_fg
,main.first_day_of_bus_year_qtr_fg AS first_day_of_bus_year_qtr_fg
,main.last_day_of_bus_year_qtr_fg AS last_day_of_bus_year_qtr_fg
,main.first_day_of_bus_half_year_fg AS first_day_of_bus_half_year_fg
,main.last_day_of_bus_half_year_fg AS last_day_of_bus_half_year_fg
,main.first_day_of_bus_year_fg AS first_day_of_bus_year_fg
,main.last_day_of_bus_year_fg AS last_day_of_bus_year_fg
,main.curr_cal_dt_fg AS curr_cal_dt_fg
,main.cal_dt_offset AS cal_dt_offset
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
FROM CORE_DIM.T_DIM_CALENDAR_DATE_1 main 
WHERE main.bus_year_offset BETWEEN -20 AND 2 ;