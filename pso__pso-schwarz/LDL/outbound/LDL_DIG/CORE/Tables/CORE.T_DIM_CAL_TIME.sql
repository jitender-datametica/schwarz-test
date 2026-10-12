CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_time (
cal_tm TIME NOT NULL OPTIONS(description='e.g.\"11:42:03.000000\' time(6) with time zone'),
second_of_day BIGNUMERIC(38,0),
second_of_hour BIGNUMERIC(38,0),
second_of_minute BIGNUMERIC(38,0),
minute_of_day BIGNUMERIC(38,0),
minute_of_hour BIGNUMERIC(38,0),
hour_of_day BIGNUMERIC(38,0),
hour_24 BIGNUMERIC(38,0),
hour_24_desc STRING(25) OPTIONS(description='00:00 - 00:59'),
hour_12 BIGNUMERIC(38,0),
hour_12_desc STRING(25) OPTIONS(description='12:00 AM - 12:59 AM'),
am_pm_ind STRING(25) OPTIONS(description='AM-PM'),
dwh_src_file_name STRING(255) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cal_tm) NOT ENFORCED
) OPTIONS(description='A dimension that contain hours and minutes of the day');