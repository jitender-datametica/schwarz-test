CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_calendar_month_1 (
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month as a number of the form YYYYMM, where YYYY is the calendar_1 year and MM_1 is month of the calendar_1 year.'),
cal_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The calendar_1 year as a number in the form YYYY. Eg. 2019'),
cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for a calendar_1 half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.'),
cal_year_qtr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The quarter of a calendar_1 year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.'),
bus_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019.'),
bus_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.'),
bus_year_qtr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. '),
cal_month_short_name STRING(100)
OPTIONS(description='The short name of the calendar_1 month in group language, i.e. in German. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name.)'),
cal_month_short_name_de STRING(100)
OPTIONS(description='The short name of the calendar_1 month in German. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name_de.)'),
cal_month_short_name_en STRING(100)
OPTIONS(description='The short name of the calendar_1 month English. E.g. Jun 2022 (This is the concatenation of cal_year and month_of_year_short_name_en.)'),
cal_month_name STRING(100)
OPTIONS(description='The name of the calendar_1 month in group language, i.e. in German. E.g. Juni 2022 (This is the concatenation of cal_year and month_of_year_name.)'),
cal_month_name_de STRING(100)
OPTIONS(description='The name of the calendar_1 month in German. E.g. Juni 2022 (This is the concatenation of cal_year and month_of_year_name_de.)'),
cal_month_name_en STRING(100)
OPTIONS(description='The name of the calendar_1 month English. E.g. June 2022 (This is the concatenation of cal_year and month_of_year_name_en.)'),
month_of_cal_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.'),
month_of_bus_year BIGNUMERIC(38,0)
OPTIONS(description='The month of the business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
month_of_year_short_name STRING(100) NOT NULL
OPTIONS(description='The short name / abbreviation for month of the year in group language, i.e. in German.'),
month_of_year_short_name_de STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in German.'),
month_of_year_short_name_en STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in English'),
month_of_year_name STRING(100) NOT NULL
OPTIONS(description='The full name for the month of the year in group language, i.e. in German.'),
month_of_year_name_de STRING(100) OPTIONS(description='The full name for the month of the year in German.'),
month_of_year_name_en STRING(100) OPTIONS(description='The full name for the month of the year in English.'),
cal_month_begin_part_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The first partial week (inclusive) of the month as a number in the form YYYYWWn. Eg. 2019182.'),
cal_month_end_part_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The last partial week (inclusive) of the month as a number in the form YYYYWWn. Eg. 2019221.'),
cal_month_begin_dt DATE NOT NULL
OPTIONS(description='The first day of the month in the form YYYY-MM_1-DD. Eg. 2019-05-01 for May 2019.'),
cal_month_end_dt DATE NOT NULL
OPTIONS(description='The last day of the month in the form YYYY-MM_1-DD. Eg. 2019-05-31 for May 2019.'),
cal_month_part_week_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of partial weeks that this month contains.'),
cal_month_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of days that this month contains. (28 / 29 / 30 / 31)'),
prev_1m_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month one month ago as a number in the form YYYYMM. Eg. 201901.'),
prev_1y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month one year ago as a number in the form YYYYMM. Eg. 201802.'),
prev_1y1m_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month one year and one month ago as a number in the form YYYYMM. Eg. 201802.'),
prev_2y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month two years ago as a number in the form YYYYMM. Eg. 201702.'),
prev_3y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month three years ago as a number in the form YYYYMM. Eg. 201602.'),
prev_4y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month four years ago as a number in the form YYYYMM. Eg. 201502. '),
prev_5y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month five years ago as a number in the form YYYYMM. Eg. 201402.'),
curr_cal_month_fg BOOL NOT NULL OPTIONS(description='This indicator is set for the current calendar_1 month.'),
cal_month_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in months between this calendar_1 month and the current month. So if current calendar_1 month is 201901, then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
cal_year_qtr_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in calendar_1 year quarters between the calendar_1 year quarter to which this month  belongs, and the current calendar_1 year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'),
cal_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in calendar_1 half years between the calendar_1 half year to which this month belongs, and the current calendar_1 half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
cal_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between the calendar_1 year to which this month belongs, and the current calendar_1 year. So if the current calendar_1 year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
bus_year_qtr_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in business year quarters between the business year quarter to which this month belongs, and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'),
bus_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in business half years between the business half year to which this month belongs, and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between the business year to which this month belongs, and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_month) NOT ENFORCED
) OPTIONS(description='The month dimension contains one record for each month in the calendar.');