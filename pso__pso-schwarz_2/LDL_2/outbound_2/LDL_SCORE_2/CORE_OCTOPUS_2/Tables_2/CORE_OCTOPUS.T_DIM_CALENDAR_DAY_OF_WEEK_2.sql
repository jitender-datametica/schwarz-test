CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_calendar_day_of_week_2 (
day_of_week BIGNUMERIC NOT NULL OPTIONS(description='Day within the year 1-7'),
day_of_week_descr STRING(100) OPTIONS(description='Name of the day Montag-Sonntag'),
day_of_week_short_descr STRING(100) OPTIONS(description='Name of the day Mo-So (short)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (day_of_week) NOT ENFORCED
) OPTIONS(description='All seven days of the week are listed and numerated by their names.');