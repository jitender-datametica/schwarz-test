CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_business_year_1 (
bus_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
bus_year_begin_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The first (calendar_1) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the March of the year specified by the field bus_year. Eg. 201903 for 2019.'),
bus_year_end_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The last (calendar_1) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the February of the year after that specified by the field bus_year.Eg. 202002 for 2019. '),
bus_year_begin_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the business year as a conventional calendar_1 date in the form\'YYYY-MM_1-DD\'. Eg.\'2019-03-01\'.'),
bus_year_end_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the business year as a conventional calendar_1 date in the form\'YYYY-MM_1-DD\'. Eg.\'2020-02-29\'. '),
bus_year_week_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of weeks that this business year contains. (i,.e. 52 or 53)'),
bus_year_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of days that this business year contains. (i,.e. 365 or 366 for leap years)'),
bus_year_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year 1 year ago as a number in the form YYYY. E.g. 2018, if the current business year is 2019.'),
bus_year_prev_2y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year 2 years ago as a number in the form YYYY. Eg. 2017, if the current business year is 2019.'),
bus_year_prev_3y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year 3 years ago as a number in the form YYYY. Eg. 2016, if the current business year is 2019.'),
bus_year_prev_4y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year 4 years ago as a number in the form YYYY. Eg. 2015, if the current business year is 2019.'),
bus_year_prev_5y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year 5 years ago as a number in the form YYYY. Eg. 2014, if the current business year is 2019.'),
bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between this business year and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year) NOT ENFORCED
)
OPTIONS(description='Lidl business years, starting in March and ending in February. Eg. Business Year 2019 is March 2019 to February 2020 inclusive.');