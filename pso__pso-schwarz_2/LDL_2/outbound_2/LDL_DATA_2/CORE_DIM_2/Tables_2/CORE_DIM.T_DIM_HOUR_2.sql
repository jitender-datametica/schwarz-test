CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_hour_2 (
hr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'),
hr_begin_tm TIME
OPTIONS(description='The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59.'),
hr_end_tm TIME
OPTIONS(description='The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (hr) NOT ENFORCED
) OPTIONS(description='This minor dimension contains the 24 hours of a day.');