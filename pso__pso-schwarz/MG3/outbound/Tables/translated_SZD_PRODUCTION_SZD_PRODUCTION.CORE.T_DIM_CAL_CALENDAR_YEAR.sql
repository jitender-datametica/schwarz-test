CREATE OR REPLACE TABLE szd_production_core.t_dim_cal_calendar_year (
cy INTEGER NOT NULL OPTIONS(description='The calendar year as a number in the form YYYY. Eg. 2019'),
cy_begin_month INTEGER NOT NULL
OPTIONS(description='The first (calendar) month (inclusive) of the calendar year as a number in the form YYYYMM. Eg. 201901.'),
cy_end_month INTEGER NOT NULL
OPTIONS(description='The last (calendar) month (inclusive) of the calendar year as a number in the form YYYYMM. Eg. 201912.'),
cy_begin_week_part INTEGER NOT NULL
OPTIONS(description='The first partial week (inclusive) of the calendar year as a number in the form YYYYWWn. Eg. 2019012.'),
cy_end_week_part INTEGER NOT NULL
OPTIONS(description='The last partial week (inclusive) of the calendar year as a number in the form YYYYWWn. Eg. 2020011.'),
cy_begin_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the calendar year as a conventional calendar date in the form "YYYY-MM-DD". Eg. "2019-01-01".'),
cy_end_dt DATE NOT NULL
OPTIONS(description='The first day (inclusive) of the calendar year as a conventional calendar date in the form "YYYY-MM-DD". Eg. "2019-12-31". '),
cy_week_cnt INTEGER OPTIONS(description='The number of weeks that this calendar year contains. (i,.e. 52 or 53)'),
cy_week_part_cnt INTEGER OPTIONS(description='The number of partial weeks that this calendar year contains.'),
cy_day_cnt INTEGER
OPTIONS(description='The number of days that this calendar year contains. (i,.e. 365 or 366 for leap years)'),
cy_prev_1y INTEGER NOT NULL
OPTIONS(description='The calendar year one year ago as a number in the form YYYY. Eg. 2018, if the current year is 2019.'),
cy_prev_2y INTEGER NOT NULL
OPTIONS(description='The calendar year two years ago as a number in the form YYYY. Eg. 2017, if the current year is 2019.'),
cy_prev_3y INTEGER NOT NULL
OPTIONS(description='The calendar year three years ago as a number in the form YYYY. Eg. 2016, if the current year is 2019.'),
cy_prev_4y INTEGER NOT NULL
OPTIONS(description='The calendar year four years ago as a number in the form YYYY. Eg. 2015, if the current year is 2019.'),
cy_prev_5y INTEGER NOT NULL
OPTIONS(description='The calendar year five years ago as a number in the form YYYY. Eg. 2014, if the current year is 2019.'),
cy_offset INTEGER
OPTIONS(description='The difference in years between this calendar year and the current calendar year. So if the current year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_src_file_name STRING(250) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cy) NOT ENFORCED
) OPTIONS(description='Calendar years, starting on January 1st and ending on December 31st.');