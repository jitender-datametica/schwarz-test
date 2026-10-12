CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_day_of_week (
day_of_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
day_of_week_short_name STRING(100) NOT NULL
OPTIONS(description='The abbreviation for the weekday in group language, i.e. in German, '),
day_of_week_short_name_de STRING(100) OPTIONS(description='The abbreviation for the weekday in German, '),
day_of_week_short_name_en STRING(100) OPTIONS(description='The abbreviation for the weekday in English.'),
day_of_week_name STRING(100) NOT NULL
OPTIONS(description='The full name for day of the week in group language, i.e. in German.'),
day_of_week_name_de STRING(100) OPTIONS(description='The full name for day of the week in German.'),
day_of_week_name_en STRING(100) OPTIONS(description='The full name for day of the week in English. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (day_of_week) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...');