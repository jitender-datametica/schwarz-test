CREATE OR REPLACE TABLE szd_production_core.t_dim_cal_month (
cy_month INTEGER NOT NULL
OPTIONS(description='The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.'),
cy INTEGER NOT NULL OPTIONS(description='The calendar year as a number in the form YYYY. Eg. 2019'),
bus_year INTEGER NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019.'),
month_of_year INTEGER NOT NULL
OPTIONS(description='The month of the calendar year as a number using the convention January = 1 ... December = 12.'),
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
cy_month_begin_week_part INTEGER NOT NULL
OPTIONS(description='The first partial week (inclusive) of the month as a number in the form YYYYWWn. Eg. 2019182.'),
cy_month_end_week_part INTEGER NOT NULL
OPTIONS(description='The last partial week (inclusive) of the month as a number in the form YYYYWWn. Eg. 2019221.'),
cy_month_begin_dt DATE NOT NULL
OPTIONS(description='The first day of the month in the form YYYY-MM-DD. Eg. 2019-05-01 for May 2019.'),
cy_month_end_dt DATE NOT NULL
OPTIONS(description='The last day of the month in the form YYYY-MM-DD. Eg. 2019-05-31 for May 2019.'),
cy_month_week_part_cnt INTEGER OPTIONS(description='The number of partial weeks that this month contains.'),
cy_month_day_cnt INTEGER OPTIONS(description='The number of days that this month contains. (28 / 29 / 30 / 31)'),
cy_month_prev_1m INTEGER NOT NULL
OPTIONS(description='The calendar month one month ago as a number in the form YYYYMM. Eg. 201901.'),
cy_month_prev_1y INTEGER NOT NULL
OPTIONS(description='The calendar month one year ago as a number in the form YYYYMM. Eg. 201802.'),
cy_month_prev_2y INTEGER NOT NULL
OPTIONS(description='The calendar month two years ago as a number in the form YYYYMM. Eg. 201702.'),
cy_month_prev_3y INTEGER NOT NULL
OPTIONS(description='The calendar month three years ago as a number in the form YYYYMM. Eg. 201602.'),
cy_month_prev_4y INTEGER NOT NULL
OPTIONS(description='The calendar month four years ago as a number in the form YYYYMM. Eg. 201502. '),
cy_month_prev_5y INTEGER NOT NULL
OPTIONS(description='The calendar month five years ago as a number in the form YYYYMM. Eg. 201402.'),
cy_month_offset INTEGER
OPTIONS(description='The difference in months between this calendar month and the current month. So if current calendar month is 201901, then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
cy_offset INTEGER
OPTIONS(description='The difference in years between the calendar year to which this month belongs, and the current calendar year. So if the current calendar year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
bus_year_offset INTEGER
OPTIONS(description='The difference in years between the business year to which this month belongs, and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cy_month) NOT ENFORCED
) OPTIONS(description='Minor Dimension - The month dimension contains one record for each month in the calendar.');