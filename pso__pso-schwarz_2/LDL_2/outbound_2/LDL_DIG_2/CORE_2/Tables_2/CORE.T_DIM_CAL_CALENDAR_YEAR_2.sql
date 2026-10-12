CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_calendar_year_2 (
cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The calendar_2 year as a number in the form YYYY. Eg. 2019'),
cy_begin_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The first (calendar_2) month (inclusive) of the calendar_2 year as a number in the form YYYYMM. Eg. 201901.'),
cy_end_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The last (calendar_2) month (inclusive) of the calendar_2 year as a number in the form YYYYMM. Eg. 201912.'),
cy_begin_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the calendar_2 year as a conventional calendar_2 date in the form\'YYYY-MM_2-DD\'. Eg.\'2019-01-01\'.'),
cy_end_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the calendar_2 year as a conventional calendar_2 date in the form\'YYYY-MM_2-DD\'. Eg.\'2019-12-31\'. '),
cy_week_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of weeks that this calendar_2 year contains. (i,.e. 52 or 53)'),
cy_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of days that this calendar_2 year contains. (i,.e. 365 or 366 for leap years)'),
cy_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 year one year ago as a number in the form YYYY. Eg. 2018, if the current year is 2019.'),
cy_prev_2y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 year two years ago as a number in the form YYYY. Eg. 2017, if the current year is 2019.'),
cy_prev_3y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 year three years ago as a number in the form YYYY. Eg. 2016, if the current year is 2019.'),
cy_prev_4y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 year four years ago as a number in the form YYYY. Eg. 2015, if the current year is 2019.'),
cy_prev_5y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 year five years ago as a number in the form YYYY. Eg. 2014, if the current year is 2019.'),
cy_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between this calendar_2 year and the current calendar_2 year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cy) NOT ENFORCED
) OPTIONS(description='Calendar_2 years, starting on January 1st and ending on December 31st.');