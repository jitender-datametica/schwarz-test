CREATE OR REPLACE TABLE production_production_core.t_dim_cal_day_2 (
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
cy INTEGER NOT NULL OPTIONS(description='The calendar_2 year as a number in the form YYYY. Eg. 2019'),
bus_year INTEGER NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
cy_month INTEGER NOT NULL
OPTIONS(description='The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.'),
month_of_year INTEGER NOT NULL
OPTIONS(description='The month of the calendar_2 year as a number using the convention January = 1 ... December = 12.'),
month_of_bus_year INTEGER NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
month_of_year_short_name STRING(100) NOT NULL
OPTIONS(description='The short name / abbreviation for month of the year in group language, i.e. in German.'),
month_of_year_short_name_de STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in German.'),
month_of_year_short_name_en STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in English.'),
month_of_year_short_name_bg STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Bulgarian.'),
month_of_year_short_name_cs STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Czech.'),
month_of_year_short_name_da STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Danish.'),
month_of_year_short_name_el STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Greek.'),
month_of_year_short_name_es STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Spanish.'),
month_of_year_short_name_fi STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Finnish.'),
month_of_year_short_name_fr STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in French.'),
month_of_year_short_name_hr STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Croatian.'),
month_of_year_short_name_hu STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Hungarian.'),
month_of_year_short_name_it STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Italian.'),
month_of_year_short_name_lt STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Lithuanian.'),
month_of_year_short_name_nl STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Dutch.'),
month_of_year_short_name_pl STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Polish.'),
month_of_year_short_name_pt STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Portuguese.'),
month_of_year_short_name_ro STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Romanian.'),
month_of_year_short_name_sh STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Serbian.'),
month_of_year_short_name_sk STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Slovak.'),
month_of_year_short_name_sl STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Slovenian.'),
month_of_year_short_name_sv STRING(100)
OPTIONS(description='The short name / abbreviation for month of the year in Swedish.'),
month_of_year_name STRING(100) NOT NULL
OPTIONS(description='The full name for the month of the year in group language, i.e. in German.'),
month_of_year_name_de STRING(100) OPTIONS(description='The full name for the month of the year in German.'),
month_of_year_name_en STRING(100) OPTIONS(description='The full name for the month of the year in English.'),
month_of_year_name_bg STRING(100) OPTIONS(description='The full name for the month of the year in Bulgarian.'),
month_of_year_name_cs STRING(100) OPTIONS(description='The full name for the month of the year in Czech.'),
month_of_year_name_da STRING(100) OPTIONS(description='The full name for the month of the year in Danish.'),
month_of_year_name_el STRING(100) OPTIONS(description='The full name for the month of the year in Greek.'),
month_of_year_name_es STRING(100) OPTIONS(description='The full name for the month of the year in Spanish.'),
month_of_year_name_fi STRING(100) OPTIONS(description='The full name for the month of the year in Finnish.'),
month_of_year_name_fr STRING(100) OPTIONS(description='The full name for the month of the year in French.'),
month_of_year_name_hr STRING(100) OPTIONS(description='The full name for the month of the year in Croatian.'),
month_of_year_name_hu STRING(100) OPTIONS(description='The full name for the month of the year in Hungarian.'),
month_of_year_name_it STRING(100) OPTIONS(description='The full name for the month of the year in Italian.'),
month_of_year_name_lt STRING(100) OPTIONS(description='The full name for the month of the year in Lithuanian.'),
month_of_year_name_nl STRING(100) OPTIONS(description='The full name for the month of the year in Dutch.'),
month_of_year_name_pl STRING(100) OPTIONS(description='The full name for the month of the year in Polish.'),
month_of_year_name_pt STRING(100) OPTIONS(description='The full name for the month of the year in Portuguese.'),
month_of_year_name_ro STRING(100) OPTIONS(description='The full name for the month of the year in Romanian.'),
month_of_year_name_sh STRING(100) OPTIONS(description='The full name for the month of the year in Serbian.'),
month_of_year_name_sk STRING(100) OPTIONS(description='The full name for the month of the year in Slovak.'),
month_of_year_name_sl STRING(100) OPTIONS(description='The full name for the month of the year in Slovenian.'),
month_of_year_name_sv STRING(100) OPTIONS(description='The full name for the month of the year in Swedish.'),
day_of_month INTEGER NOT NULL
OPTIONS(description='The sequence number of the day within the month. Simply the calendar_2 day number in the calendar_2 month. A number between 1 and 31.   '),
cy_week INTEGER NOT NULL
OPTIONS(description='The week to which this week belongs, as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_2 year. Week 1 is the first week in the calendar_2 year containing at least 4 days.'),
week_of_year INTEGER NOT NULL
OPTIONS(description='The number of the week within the calendar_2 year, to which this day belongs., i.e. a number between 1 and 53. Week 1 is the first week in the calendar_2 year containing at least 4 days, therefore the first week containing a Thursday.'),
cy_week_part INTEGER NOT NULL
OPTIONS(description='The partial week, to which this day belongs, as a number of the form YYYYWWn. YYYY is the calendar_2 year and WW is the number of the week within the year and n is sequence number (1 or 2) of the partial week within the week.'),
week_part_seq INTEGER NOT NULL
OPTIONS(description='The sequence number of the partial week, to which this day belongs, within the week, that contains that partial week. (1 or 2)'),
day_of_week INTEGER NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
day_of_week_short_name STRING(100) NOT NULL
OPTIONS(description='The abbreviation for the weekday in group language, i.e. in German, '),
day_of_week_short_name_de STRING(100) OPTIONS(description='The abbreviation for the weekday in German, '),
day_of_week_short_name_en STRING(100) OPTIONS(description='The abbreviation for the weekday in English.'),
day_of_week_short_name_bg STRING(100) OPTIONS(description='The abbreviation for the weekday in Bulgarian.'),
day_of_week_short_name_cs STRING(100) OPTIONS(description='The abbreviation for the weekday in Czech.'),
day_of_week_short_name_da STRING(100) OPTIONS(description='The abbreviation for the weekday in Danish.'),
day_of_week_short_name_el STRING(100) OPTIONS(description='The abbreviation for the weekday in Greek.'),
day_of_week_short_name_es STRING(100) OPTIONS(description='The abbreviation for the weekday in Spanish.'),
day_of_week_short_name_fi STRING(100) OPTIONS(description='The abbreviation for the weekday in Finnish.'),
day_of_week_short_name_fr STRING(100) OPTIONS(description='The abbreviation for the weekday in French.'),
day_of_week_short_name_hr STRING(100) OPTIONS(description='The abbreviation for the weekday in Croatian.'),
day_of_week_short_name_hu STRING(100) OPTIONS(description='The abbreviation for the weekday in Hungarian.'),
day_of_week_short_name_it STRING(100) OPTIONS(description='The abbreviation for the weekday in Italian.'),
day_of_week_short_name_lt STRING(100) OPTIONS(description='The abbreviation for the weekday in Lithuanian.'),
day_of_week_short_name_nl STRING(100) OPTIONS(description='The abbreviation for the weekday in Dutch.'),
day_of_week_short_name_pl STRING(100) OPTIONS(description='The abbreviation for the weekday in Polish.'),
day_of_week_short_name_pt STRING(100) OPTIONS(description='The abbreviation for the weekday in Portuguese. '),
day_of_week_short_name_ro STRING(100) OPTIONS(description='The abbreviation for the weekday in Romanian.'),
day_of_week_short_name_sh STRING(100) OPTIONS(description='The abbreviation for the weekday in Serbian.'),
day_of_week_short_name_sk STRING(100) OPTIONS(description='The abbreviation for the weekday in Slovak.'),
day_of_week_short_name_sl STRING(100) OPTIONS(description='The abbreviation for the weekday in Slovenian.'),
day_of_week_short_name_sv STRING(100) OPTIONS(description='The abbreviation for the weekday in Swedish.'),
day_of_week_name STRING(100) NOT NULL
OPTIONS(description='The full name for day of the week in group language, i.e. in German.'),
day_of_week_name_de STRING(100) OPTIONS(description='The full name for day of the week in German.'),
day_of_week_name_en STRING(100) OPTIONS(description='The full name for day of the week in English. '),
day_of_week_name_bg STRING(100) OPTIONS(description='The full name for day of the week in Bulgarian. '),
day_of_week_name_cs STRING(100) OPTIONS(description='The full name for day of the week in Czech.'),
day_of_week_name_da STRING(100) OPTIONS(description='The full name for day of the week in Danish.'),
day_of_week_name_el STRING(100) OPTIONS(description='The full name for day of the week in Greek.'),
day_of_week_name_es STRING(100) OPTIONS(description='The full name for day of the week in Spanish.'),
day_of_week_name_fi STRING(100) OPTIONS(description='The full name for day of the week in Finnish.'),
day_of_week_name_fr STRING(100) OPTIONS(description='The full name for day of the week in French. '),
day_of_week_name_hr STRING(100) OPTIONS(description='The full name for day of the week in Croatian.'),
day_of_week_name_hu STRING(100) OPTIONS(description='The full name for day of the week in Hungarian.'),
day_of_week_name_it STRING(100) OPTIONS(description='The full name for day of the week in Italian. '),
day_of_week_name_lt STRING(100) OPTIONS(description='The full name for day of the week in Lithuanian. '),
day_of_week_name_nl STRING(100) OPTIONS(description='The full name for day of the week in Dutch. '),
day_of_week_name_pl STRING(100) OPTIONS(description='The full name for day of the week in Polish. '),
day_of_week_name_pt STRING(100) OPTIONS(description='The full name for day of the week in Portuguese. '),
day_of_week_name_ro STRING(100) OPTIONS(description='The full name for day of the week in Romanian.'),
day_of_week_name_sh STRING(100) OPTIONS(description='The full name for day of the week in Serbian. '),
day_of_week_name_sk STRING(100) OPTIONS(description='The full name for day of the week in Slovak.'),
day_of_week_name_sl STRING(100) OPTIONS(description='The full name for day of the week in Slovenian. '),
day_of_week_name_sv STRING(100) OPTIONS(description='The full name for day of the week in Swedish.'),
day_of_cy INTEGER NOT NULL
OPTIONS(description='The sequence number of the day within in the calendar_2 year. A number between 1 and 366. January 1st will always be 1 and December 31st always 365 or 366 for leap years.'),
day_of_bus_year INTEGER NOT NULL
OPTIONS(description='The sequence number of the day within in the business year. A number between 1 and 366. March 1st will always be 1, February 28th always 365 and February 29th always 366.'),
cal_dt_prev_1d DATE NOT NULL OPTIONS(description='The calendar_2 date of the same day 1 day ago,'),
cal_dt_prev_1w DATE NOT NULL OPTIONS(description='The calendar_2 date of the same day 1 week ago, '),
cal_dt_prev_1m DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same day 1 month ago. Calculated by offsetting cal_dt by -1 month. If the corresponding day does not exist in the target month then Null is returned. '),
cal_dt_prev_1y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same day 1 year ago. Calculated by subtracting 12 months. If there are insufficient days in the target month, the last day in the month is returned.'),
cal_dt_prev_2y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same day 2 years ago. Calculated by subtracting 24 months. If there are insufficient days in the target month the last day in the month is returned. '),
cal_dt_prev_3y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same day 3 years ago. Calculated by subtracting 36 months. If there are insufficient days in the target month the last day in the month is returned.'),
cal_dt_prev_4y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same day 4 years ago. Calculated by subtracting 48 months. If there are insufficient days in the target month the last day in the month is returned. '),
cal_dt_prev_5y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same day 5 years ago. Calculated by subtracting 60 months. If there are insufficient days in the target month the last day in the month is returned.'),
cal_dt_swday_prev_1m DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same weekday (approximately) 1 month ago. Calculated by offsetting cal_dt by -28 (days) i.e. 4 weeks. '),
cal_dt_swday_prev_1y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same weekday (approximately) 1 year ago.  Calculated by offsetting cal_dt by -364 (days) ie. 52 weeks. '),
cal_dt_swday_prev_2y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same weekday (approximately) 2 years ago. Calculated by offsetting cal_dt by -728 (days) i.e. 104 weeks. '),
cal_dt_swday_prev_3y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same weekday (approximately) 3 years ago. Calculated by offsetting cal_dt by -1092 (days) i.e. 156 weeks. '),
cal_dt_swday_prev_4y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same weekday (approximately) 4 years ago. Calculated by offsetting cal_dt by -1456 (days) i.e. 208 weeks. '),
cal_dt_swday_prev_5y DATE NOT NULL
OPTIONS(description='The calendar_2 date of the same weekday (approximately) 5 years ago. Calculated by offsetting cal_dt by -1820 (days) i.e. 260 weeks. '),
first_day_of_week_part_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the first day of the containing partial week.'),
last_day_of_week_part_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the last day of the containing partial week.'),
first_day_of_week_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the first day of the containing week.'),
last_day_of_week_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the last day of the containing week.'),
first_day_of_month_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the first day of the containing month.'),
last_day_of_month_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the last day of the containing month.'),
first_day_of_cy_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the first day of the containing calendar_2 year.'),
last_day_of_cy_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the last day of the containing calendar_2 year.'),
first_day_of_bus_year_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the first day of the containing business year.'),
last_day_of_bus_year_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the last day of the containing business year.'),
cal_dt_offset INTEGER
OPTIONS(description='The difference in days between this day and the current date. So if the current date is 2019-05-02, then this offset is 0 for 2019-05-02, -1 for 2019-05-01 and +1 for 2019-05-03.'),
cy_week_part_offset INTEGER
OPTIONS(description='The difference in partial weeks between this partial week and the current partial week (or week).'),
cy_week_offset INTEGER
OPTIONS(description='The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101.  '),
cy_month_offset INTEGER
OPTIONS(description='The difference in months between this calendar_2 month and the current calendar_2 month. So if current calendar_2 month is 201901 then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
cy_offset INTEGER
OPTIONS(description='The difference in years between this calendar_2 year and the current calendar_2 year. So if the current calendar_2 year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
bus_year_offset INTEGER
OPTIONS(description='The difference in years between this business year and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020. '),
dwh_src_file_name STRING(16777216) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='The main time dimension for all days in the calendar.');