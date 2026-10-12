CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_day_of_week_2 (
day_of_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
day_of_week_short_name STRING(100) NOT NULL
OPTIONS(description='The abbreviation for the weekday in group language, i.e. in German, '),
day_of_week_short_name_de STRING(100) OPTIONS(description='The abbreviation for the weekday in German, '),
day_of_week_short_name_en STRING(100) OPTIONS(description='The abbreviation for the weekday in English'),
day_of_week_name STRING(100) NOT NULL
OPTIONS(description='The full name for day of the week in group language, i.e. in German.'),
day_of_week_name_de STRING(100) OPTIONS(description='The full name for day of the week in German.'),
day_of_week_name_en STRING(100) OPTIONS(description='The full name for day of the week in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (day_of_week) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...');