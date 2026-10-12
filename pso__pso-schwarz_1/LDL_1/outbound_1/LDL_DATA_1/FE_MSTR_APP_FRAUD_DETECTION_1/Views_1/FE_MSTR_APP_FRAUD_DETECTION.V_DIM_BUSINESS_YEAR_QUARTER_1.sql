CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_business_year_quarter_1 (bus_year_qtr
OPTIONS(description='The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. '),
bus_year OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'), bus_half_year
OPTIONS(description='The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.'),
bus_year_qtr_name
OPTIONS(description='The text which is displayed for the quarter of the business year in reports, in group language, i.e. German. E.g. Q1/2021 for the first quarter of the business year 2021.'),
bus_year_qtr_name_de
OPTIONS(description='The text which is displayed for the quarter of the business year in reports, in German. E.g. Q1/2021 for the first quarter of the business year 2021.'),
bus_year_qtr_name_en
OPTIONS(description='The text which is displayed for the quarter of the business year in reports, in English. E.g. Q1/2021 for the first quarter of the business year 2021.'),
qtr_of_bus_year OPTIONS(description='The number of the quarter within the business year. E.g. 3 for Q3/2021.'),
bus_year_qtr_begin_month
OPTIONS(description='The first (calendar_1) month (inclusive) of the business year quarter as a number in the form YYYYMM. Eg. 202101.'),
bus_year_qtr_end_month
OPTIONS(description='The last (calendar_1) month (inclusive) of the business year quarter as a number in the form YYYYMM. Eg. 202103.'),
bus_year_qtr_begin_part_week
OPTIONS(description='The first partial week (inclusive) of the business year quarter as a number in the form YYYYWWn. Eg. 2021011.'),
bus_year_qtr_end_part_week
OPTIONS(description='The last partial week (inclusive) of the business year quarter as a number in the form YYYYWWn. Eg. 2021131.'),
bus_year_qtr_begin_dt
OPTIONS(description='The first day (inclusive) of the business year quarter as a conventional calendar_1 date in the form\'YYYY-MM_1-DD\'. Eg.\'2021-01-01\'.'),
bus_year_qtr_end_dt
OPTIONS(description='The first day (inclusive) of the business year quarter as a conventional calendar_1 date in the form\'YYYY-MM_1-DD\'. Eg.\'2021-03-31\'. '),
bus_year_qtr_week_cnt
OPTIONS(description='The number of weeks that this business year quarter contains. If a week spans two quarters, it is counted for the quarter, in which it has at least four days.'),
bus_year_qtr_part_week_cnt OPTIONS(description='The number of partial weeks that this business year quarter contains.'),
bus_year_qtr_day_cnt OPTIONS(description='The number of days that this business year quarter contains.'),
prev_1y_bus_year_qtr
OPTIONS(description='The business year quarter one year ago as a number in the form YYYYn. Eg. 20201, if the current quarter is 20211.'),
prev_2y_bus_year_qtr
OPTIONS(description='The business year quarter two years ago as a number in the form YYYYn. Eg. 20191, if the current quarter is 20211.'),
prev_3y_bus_year_qtr
OPTIONS(description='The business year quarter three years ago as a number in the form YYYYn. Eg. 20181, if the current quarter is 20211.'),
prev_4y_bus_year_qtr
OPTIONS(description='The business year quarter four years ago as a number in the form YYYYn. Eg. 20171, if the current quarter is 20211.'),
prev_5y_bus_year_qtr
OPTIONS(description='The business year quarter five years ago as a number in the form YYYYn. Eg. 20161, if the current quarter is 20211.'),
curr_bus_year_qtr_fg OPTIONS(description='This indicator is set for the current quarter of the business year.'),
bus_year_qtr_offset
OPTIONS(description='The difference in business year quarters between this business year quarter and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'),
bus_half_year_offset
OPTIONS(description='The difference in business half years between the business half year to which this business year quarter belongs, and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
bus_year_offset
OPTIONS(description='The difference in years between the business year to which this business half quarter belongs, and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  '),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE QUARTER OF THE BUSINESS YEAR, E.G. Q1/2021 STARTING ON MARCH 1ST 2021 AND ENDING ON MAY 31ST 2021. (Q1 INCLUDES MARCH, APRIL AND MAY. Q2 INCLUDES JUNE, JULY AND AUGUST. Q3 INCLUDES SEPTEMBER, OCTOBER AND NOVEMBER. Q4 INCLUDES DECEMBER, JANUARY AND FEBRUARY.)`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_business_year_quarter_1 AS MAIN
WHERE bus_year_offset BETWEEN - 20 AND 2;