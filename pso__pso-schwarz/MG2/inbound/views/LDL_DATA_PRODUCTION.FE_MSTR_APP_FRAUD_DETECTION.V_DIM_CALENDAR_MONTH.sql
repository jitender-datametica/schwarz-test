create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_CALENDAR_MONTH(
	CAL_MONTH COMMENT 'The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.',
	CAL_YEAR COMMENT 'The calendar year as a number in the form YYYY. Eg. 2019',
	CAL_HALF_YEAR COMMENT 'The identifier for a calendar half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.',
	CAL_YEAR_QTR COMMENT 'The quarter of a calendar year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.',
	BUS_YEAR COMMENT 'The business year as a number in the form YYYY. Eg. 2019.',
	BUS_HALF_YEAR COMMENT 'The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.',
	BUS_YEAR_QTR COMMENT 'The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. ',
	CAL_MONTH_SHORT_NAME COMMENT 'The short name of the calendar month in group language, i.e. in German. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name.)',
	CAL_MONTH_SHORT_NAME_DE COMMENT 'The short name of the calendar month in German. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name_de.)',
	CAL_MONTH_SHORT_NAME_EN COMMENT 'The short name of the calendar month English. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name_en.)',
	CAL_MONTH_NAME COMMENT 'The name of the calendar month in group language, i.e. in German. E.g. Juni 2022 (This is the concatenation of cal_year and month_of_year_name.)',
	CAL_MONTH_NAME_DE COMMENT 'The name of the calendar month in German. E.g. Juni 2022 (This is the concatenation of cal_year and month_of_year_name_de.)',
	CAL_MONTH_NAME_EN COMMENT 'The name of the calendar month English. E.g. June 2022 (This is the concatenation of cal_year and month_of_year_name_en.)',
	MONTH_OF_CAL_YEAR COMMENT 'The month of the calendar year as a number using the convention January = 1 ... December = 12.',
	MONTH_OF_BUS_YEAR COMMENT 'The month of the business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
	MONTH_OF_YEAR_SHORT_NAME COMMENT 'The short name / abbreviation for month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_SHORT_NAME_DE COMMENT 'The short name / abbreviation for month of the year in German.',
	MONTH_OF_YEAR_SHORT_NAME_EN COMMENT 'The short name / abbreviation for month of the year in English',
	MONTH_OF_YEAR_NAME COMMENT 'The full name for the month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_NAME_DE COMMENT 'The full name for the month of the year in German.',
	MONTH_OF_YEAR_NAME_EN COMMENT 'The full name for the month of the year in English.',
	CAL_MONTH_BEGIN_PART_WEEK COMMENT 'The first partial week (inclusive) of the month as a number in the form YYYYWWn. Eg. 2019182.',
	CAL_MONTH_END_PART_WEEK COMMENT 'The last partial week (inclusive) of the month as a number in the form YYYYWWn. Eg. 2019221.',
	CAL_MONTH_BEGIN_DT COMMENT 'The first day of the month in the form YYYY-MM-DD. Eg. 2019-05-01 for May 2019.',
	CAL_MONTH_END_DT COMMENT 'The last day of the month in the form YYYY-MM-DD. Eg. 2019-05-31 for May 2019.',
	CAL_MONTH_PART_WEEK_CNT COMMENT 'The number of partial weeks that this month contains.',
	CAL_MONTH_DAY_CNT COMMENT 'The number of days that this month contains. (28 / 29 / 30 / 31)',
	PREV_1M_CAL_MONTH COMMENT 'The calendar month one month ago as a number in the form YYYYMM. Eg. 201901.',
	PREV_1Y_CAL_MONTH COMMENT 'The calendar month one year ago as a number in the form YYYYMM. Eg. 201802.',
	PREV_1Y1M_CAL_MONTH COMMENT 'The calendar month one year and one month ago as a number in the form YYYYMM. Eg. 201802.',
	PREV_2Y_CAL_MONTH COMMENT 'The calendar month two years ago as a number in the form YYYYMM. Eg. 201702.',
	PREV_3Y_CAL_MONTH COMMENT 'The calendar month three years ago as a number in the form YYYYMM. Eg. 201602.',
	PREV_4Y_CAL_MONTH COMMENT 'The calendar month four years ago as a number in the form YYYYMM. Eg. 201502. ',
	PREV_5Y_CAL_MONTH COMMENT 'The calendar month five years ago as a number in the form YYYYMM. Eg. 201402.',
	CURR_CAL_MONTH_FG COMMENT 'This indicator is set for the current calendar month.',
	CAL_MONTH_OFFSET COMMENT 'The difference in months between this calendar month and the current month. So if current calendar month is 201901, then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.',
	CAL_YEAR_QTR_OFFSET COMMENT 'The difference in calendar year quarters between the calendar year quarter to which this month  belongs, and the current calendar year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	CAL_HALF_YEAR_OFFSET COMMENT 'The difference in calendar half years between the calendar half year to which this month belongs, and the current calendar half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	CAL_YEAR_OFFSET COMMENT 'The difference in years between the calendar year to which this month belongs, and the current calendar year. So if the current calendar year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	BUS_YEAR_QTR_OFFSET COMMENT 'The difference in business year quarters between the business year quarter to which this month belongs, and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.',
	BUS_HALF_YEAR_OFFSET COMMENT 'The difference in business half years between the business half year to which this month belongs, and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.',
	BUS_YEAR_OFFSET COMMENT 'The difference in years between the business year to which this month belongs, and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The month dimension contains one record for each month in the calendar.'
 as SELECT
main.cal_month AS cal_month
,main.cal_year AS cal_year
,main.cal_half_year AS cal_half_year
,main.cal_year_qtr AS cal_year_qtr
,main.bus_year AS bus_year
,main.bus_half_year AS bus_half_year
,main.bus_year_qtr AS bus_year_qtr
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
,main.cal_month_begin_part_week AS cal_month_begin_part_week
,main.cal_month_end_part_week AS cal_month_end_part_week
,main.cal_month_begin_dt AS cal_month_begin_dt
,main.cal_month_end_dt AS cal_month_end_dt
,main.cal_month_part_week_cnt AS cal_month_part_week_cnt
,main.cal_month_day_cnt AS cal_month_day_cnt
,main.prev_1m_cal_month AS prev_1m_cal_month
,main.prev_1y_cal_month AS prev_1y_cal_month
,main.prev_1y1m_cal_month AS prev_1y1m_cal_month
,main.prev_2y_cal_month AS prev_2y_cal_month
,main.prev_3y_cal_month AS prev_3y_cal_month
,main.prev_4y_cal_month AS prev_4y_cal_month
,main.prev_5y_cal_month AS prev_5y_cal_month
,main.curr_cal_month_fg AS curr_cal_month_fg
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
FROM CORE_DIM.T_DIM_CALENDAR_MONTH main WHERE main.bus_year_offset BETWEEN -20 AND 2 ;