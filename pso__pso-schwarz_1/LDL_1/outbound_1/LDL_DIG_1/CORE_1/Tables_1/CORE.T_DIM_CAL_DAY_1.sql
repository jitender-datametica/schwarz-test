CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_day_1 (
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
cy BIGNUMERIC(38,0) OPTIONS(description='The calendar_1 year as a number in the form YYYY. Eg. 2019'),
bus_year BIGNUMERIC(38,0) OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
cy_month BIGNUMERIC(38,0)
OPTIONS(description='The calendar_1 month as a number of the form YYYYMM, where YYYY is the calendar_1 year and MM_1 is month of the calendar_1 year.'),
month_of_year BIGNUMERIC(38,0)
OPTIONS(description='The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.'),
month_of_bus_year BIGNUMERIC(38,0)
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
month_of_year_short_name STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in group language, i.e. in German.'),
month_of_year_short_name_de STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in German.'),
month_of_year_short_name_en STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in English.'),
month_of_year_name STRING(100)
OPTIONS(description='The full name for the month of the year in group language, i.e. in German.'),
month_of_year_name_de STRING(100) OPTIONS(description='The full name for the month of the year in German.'),
month_of_year_name_en STRING(100) OPTIONS(description='The full name for the month of the year in English.'),
day_of_month BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the month. Simply the calendar_1 day number in the calendar_1 month. A number between 1 and 31.   '),
cy_quarter BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0)
OPTIONS(description='The week to which this week belongs, as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.'),
week_of_year BIGNUMERIC(38,0)
OPTIONS(description='The number of the week within the calendar_1 year, to which this day belongs., i.e. a number between 1 and 53. Week 1 is the first week in the calendar_1 year containing at least 4 days, therefore the first week containing a Thursday.'),
day_of_week BIGNUMERIC(38,0)
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
day_of_week_short_name STRING(100)
OPTIONS(description='The abbreviation for the weekday in group language, i.e. in German, '),
day_of_week_short_name_de STRING(100) OPTIONS(description='The abbreviation for the weekday in German, '),
day_of_week_short_name_en STRING(100) OPTIONS(description='The abbreviation for the weekday in English.'),
day_of_week_name STRING(100) OPTIONS(description='The full name for day of the week in group language, i.e. in German.'),
day_of_week_name_de STRING(100) OPTIONS(description='The full name for day of the week in German.'),
day_of_week_name_en STRING(100) OPTIONS(description='The full name for day of the week in English. '),
day_of_cy BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within in the calendar_1 year. A number between 1 and 366. January 1st will always be 1 and December 31st always 365 or 366 for leap years.'),
day_of_bus_year BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within in the business year. A number between 1 and 366. March 1st will always be 1, February 28th always 365 and February 29th always 366.'),
cal_dt_prev_1d DATE OPTIONS(description='The calendar_1 date of the same day 1 day ago,'),
cal_dt_prev_1w DATE OPTIONS(description='The calendar_1 date of the same day 1 week ago, '),
cal_dt_prev_1m DATE
OPTIONS(description='The calendar_1 date of the same day 1 month ago. Calculated by offsetting cal_dt by -1 month. If the corresponding day does not exist in the target month then Null is returned. '),
cal_dt_prev_1y DATE
OPTIONS(description='The calendar_1 date of the same day 1 year ago. Calculated by subtracting 12 months. If there are insufficient days in the target month, the last day in the month is returned.'),
cal_dt_prev_2y DATE
OPTIONS(description='The calendar_1 date of the same day 2 years ago. Calculated by subtracting 24 months. If there are insufficient days in the target month the last day in the month is returned. '),
cal_dt_prev_3y DATE
OPTIONS(description='The calendar_1 date of the same day 3 years ago. Calculated by subtracting 36 months. If there are insufficient days in the target month the last day in the month is returned.'),
cal_dt_prev_4y DATE
OPTIONS(description='The calendar_1 date of the same day 4 years ago. Calculated by subtracting 48 months. If there are insufficient days in the target month the last day in the month is returned. '),
cal_dt_prev_5y DATE
OPTIONS(description='The calendar_1 date of the same day 5 years ago. Calculated by subtracting 60 months. If there are insufficient days in the target month the last day in the month is returned.'),
cal_dt_swday_prev_1m DATE
OPTIONS(description='The calendar_1 date of the same weekday (approximately) 1 month ago. Calculated by offsetting cal_dt by -28 (days) i.e. 4 weeks. '),
cal_dt_swday_prev_1y DATE
OPTIONS(description='The calendar_1 date of the same weekday (approximately) 1 year ago.  Calculated by offsetting cal_dt by -364 (days) ie. 52 weeks. '),
cal_dt_swday_prev_2y DATE
OPTIONS(description='The calendar_1 date of the same weekday (approximately) 2 years ago. Calculated by offsetting cal_dt by -728 (days) i.e. 104 weeks. '),
cal_dt_swday_prev_3y DATE
OPTIONS(description='The calendar_1 date of the same weekday (approximately) 3 years ago. Calculated by offsetting cal_dt by -1092 (days) i.e. 156 weeks. '),
cal_dt_swday_prev_4y DATE
OPTIONS(description='The calendar_1 date of the same weekday (approximately) 4 years ago. Calculated by offsetting cal_dt by -1456 (days) i.e. 208 weeks. '),
cal_dt_swday_prev_5y DATE
OPTIONS(description='The calendar_1 date of the same weekday (approximately) 5 years ago. Calculated by offsetting cal_dt by -1820 (days) i.e. 260 weeks. '),
first_day_of_week_fg BOOL OPTIONS(description='An indicator showing, if this is the first day of the containing week.'),
last_day_of_week_fg BOOL OPTIONS(description='An indicator showing, if this is the last day of the containing week.'),
first_day_of_month_fg BOOL
OPTIONS(description='An indicator showing, if this is the first day of the containing month.'),
last_day_of_month_fg BOOL OPTIONS(description='An indicator showing, if this is the last day of the containing month.'),
first_day_of_cy_fg BOOL
OPTIONS(description='An indicator showing, if this is the first day of the containing calendar_1 year.'),
last_day_of_cy_fg BOOL
OPTIONS(description='An indicator showing, if this is the last day of the containing calendar_1 year.'),
first_day_of_bus_year_fg BOOL
OPTIONS(description='An indicator showing, if this is the first day of the containing business year.'),
last_day_of_bus_year_fg BOOL
OPTIONS(description='An indicator showing, if this is the last day of the containing business year.'),
cal_dt_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in days between this day and the current date. So if the current date is 2019-05-02, then this offset is 0 for 2019-05-02, -1 for 2019-05-01 and +1 for 2019-05-03.'),
cy_week_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101.  '),
cy_month_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in months between this calendar_1 month and the current calendar_1 month. So if current calendar_1 month is 201901 then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
cy_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between this calendar_1 year and the current calendar_1 year. So if the current calendar_1 year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in years between this business year and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020. '),
cy_quarter_offset BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='The main date dimension for all days in the calendar.');