CREATE OR REPLACE VIEW fe_mstr_master.v_dim_business_year_1 (bus_year
OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'), bus_year_begin_month
OPTIONS(description='The first (calendar_1) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the March of the year specified by the field bus_year. Eg. 201903 for 2019.'),
bus_year_end_month
OPTIONS(description='The last (calendar_1) month (inclusive) of the business year as a number in the form YYYYMM, i.e. the February of the year after that specified by the field bus_year.Eg. 202002 for 2019. '),
bus_year_begin_part_week
OPTIONS(description='The first partial week (inclusive) of the business year as a number in the form YYYYWWn. Eg. 2019092.'),
bus_year_end_part_week
OPTIONS(description='The last partial week (inclusive) of the business year as a number in the form YYYYWWn. Eg. 2020091.'),
bus_year_begin_dt
OPTIONS(description='The first day (inclusive) of the business year as a conventional calendar_1 date in the form\'YYYY-MM_1-DD\'. Eg.\'2019-03-01\'.'),
bus_year_end_dt
OPTIONS(description='The first day (inclusive) of the business year as a conventional calendar_1 date in the form\'YYYY-MM_1-DD\'. Eg.\'2020-02-29\'. '),
bus_year_week_cnt
OPTIONS(description='The number of weeks that this business year contains. (i,.e. 52 or 53) If a week spans two business years, it is counted for the year, in which it has at least four days.'),
bus_year_part_week_cnt OPTIONS(description='The number of partial weeks that this business year contains.'),
bus_year_day_cnt
OPTIONS(description='The number of days that this business year contains. (i,.e. 365 or 366 for leap years)'),
leap_year_fg OPTIONS(description='An indicator showing, if this year is a leap year, i.e. if it has 366 days.'),
prev_1y_bus_year
OPTIONS(description='The business year 1 year ago as a number in the form YYYY. E.g. 2018, if the current business year is 2019.'),
prev_2y_bus_year
OPTIONS(description='The business year 2 years ago as a number in the form YYYY. Eg. 2017, if the current business year is 2019.'),
prev_3y_bus_year
OPTIONS(description='The business year 3 years ago as a number in the form YYYY. Eg. 2016, if the current business year is 2019.'),
prev_4y_bus_year
OPTIONS(description='The business year 4 years ago as a number in the form YYYY. Eg. 2015, if the current business year is 2019.'),
prev_5y_bus_year
OPTIONS(description='The business year 5 years ago as a number in the form YYYY. Eg. 2014, if the current business year is 2019.'),
curr_bus_year_fg OPTIONS(description='This indicator is set for the current business year.'), bus_year_offset
OPTIONS(description='The difference in years between this business year and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  '),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `LIDL BUSINESS YEARS, STARTING IN MARCH AND ENDING IN FEBRUARY. EG. BUSINESS YEAR 2019 IS MARCH 2019 TO FEBRUARY 2020 INCLUSIVE.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_business_year_1 AS MAIN
WHERE bus_year_offset BETWEEN - 20 AND 2;