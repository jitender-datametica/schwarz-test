CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_month (
cy_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.'),
cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The calendar year as a number in the form YYYY. Eg. 2019'),
bus_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019.'),
month_of_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The month of the calendar year as a number using the convention January = 1 ... December = 12.'),
month_of_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
month_of_year_short_name STRING(100) NOT NULL
OPTIONS(description='The short name / abbreviation for month of the year in group language, i.e. in German.'),
month_of_year_short_name_de STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in German.'),
month_of_year_short_name_en STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in English.'),
month_of_year_name STRING(100) NOT NULL
OPTIONS(description='The full name for the month of the year in group language, i.e. in German.'),
month_of_year_name_de STRING(100) OPTIONS(description='The full name for the month of the year in German.'),
month_of_year_name_en STRING(100) OPTIONS(description='The full name for the month of the year in English.'),
cy_month_begin_dt DATE NOT NULL
OPTIONS(description='The first day of the month in the form YYYY-MM-DD. Eg. 2019-05-01 for May 2019.'),
cy_month_end_dt DATE NOT NULL
OPTIONS(description='The last day of the month in the form YYYY-MM-DD. Eg. 2019-05-31 for May 2019.'),
cy_month_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of days that this month contains. (28 / 29 / 30 / 31)'),
cy_month_prev_1m BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month one month ago as a number in the form YYYYMM. Eg. 201901.'),
cy_month_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month one year ago as a number in the form YYYYMM. Eg. 201802.'),
cy_month_prev_2y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month two years ago as a number in the form YYYYMM. Eg. 201702.'),
cy_month_prev_3y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month three years ago as a number in the form YYYYMM. Eg. 201602.'),
cy_month_prev_4y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month four years ago as a number in the form YYYYMM. Eg. 201502. '),
cy_month_prev_5y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month five years ago as a number in the form YYYYMM. Eg. 201402.'),
cy_month_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in months between this calendar month and the current month. So if current calendar month is 201901, then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
cy_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between the calendar year to which this month belongs, and the current calendar year. So if the current calendar year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between the business year to which this month belongs, and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
cy_month_name_de STRING(100) OPTIONS(description='The year and full name of month in German'),
cy_month_name_en STRING(100) OPTIONS(description='The year and full name of month in English.'),
PRIMARY KEY (cy_month) NOT ENFORCED
) OPTIONS(description='The month dimension contains one record for each month in the calendar.');