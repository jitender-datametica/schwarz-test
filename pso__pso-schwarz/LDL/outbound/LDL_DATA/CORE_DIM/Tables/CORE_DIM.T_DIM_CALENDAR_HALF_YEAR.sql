CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_calendar_half_year (
cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier for a calendar half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.'),
cal_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The calendar year as a number in the form YYYY. Eg. 2019'),
cal_half_year_name STRING(100) NOT NULL
OPTIONS(description='The text which is displayed for the calendar half year in reports, in group language, i.e. German. E.g. 2021-HJ1 for the first half of the calendar year 2021.'),
cal_half_year_name_de STRING(100)
OPTIONS(description='The text which is displayed for the calendar half year in reports, in German. E.g. 2021-HJ1 for the first half of the calendar year 2021.'),
cal_half_year_name_en STRING(100)
OPTIONS(description='The text which is displayed for the calendar half year in reports, in English. E.g. 2021-HY1 for the first half of the calendar year 2021.'),
half_of_cal_year BIGNUMERIC(38,0)
OPTIONS(description='The number of the half year within the calendar year. E.g. 1 for the first half year of 2021.'),
cal_half_year_begin_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The first (calendar) month (inclusive) of the calendar half year as a number in the form YYYYMM. Eg. 201901.'),
cal_half_year_end_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The last (calendar) month (inclusive) of the calendar half year as a number in the form YYYYMM. Eg. 201912.'),
cal_half_year_begin_part_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The first partial week (inclusive) of the calendar half year as a number in the form YYYYWWn. Eg. 2019012.'),
cal_half_year_end_part_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The last partial week (inclusive) of the calendar half year as a number in the form YYYYWWn. Eg. 2020011.'),
cal_half_year_begin_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the calendar half year as a conventional calendar date in the form\'YYYY-MM-DD\'. Eg.\'2019-01-01\'.'),
cal_half_year_end_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the calendar half year as a conventional calendar date in the form\'YYYY-MM-DD\'. Eg.\'2019-12-31\'. '),
cal_half_year_week_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of weeks that this calendar half year contains. If a week spans two half years, it is counted for the half year, in which it has at least four days.'),
cal_half_year_part_week_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of partial weeks that this calendar half year contains.'),
cal_half_year_day_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of days that this calendar half year contains.'),
prev_1y_cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar half year one year ago as a number in the form YYYYn. Eg. 20201, if the current half year is 20211.'),
prev_2y_cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar half year two years ago as a number in the form YYYYn. Eg. 20191, if the current half year is 20211.'),
prev_3y_cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar half year three years ago as a number in the form YYYYn. Eg. 20181, if the current half year is 20211.'),
prev_4y_cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar half year four years ago as a number in the form YYYYn. Eg. 20171, if the current half year is 20211.'),
prev_5y_cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar half year five years ago as a number in the form YYYYn. Eg. 20161, if the current half year is 20211.'),
curr_cal_half_year_fg BOOL NOT NULL OPTIONS(description='This indicator is set for the current calendar half year.'),
cal_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in calendar half years between this calendar half year and the current calendar half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
cal_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between the calendar year to which this half year belongs, and the current calendar year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_half_year) NOT ENFORCED
)
OPTIONS(description='A half year in the calendar. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.');