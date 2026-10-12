CREATE OR REPLACE TABLE szd_production_core_rel.t_hour_2 (
hr_id INTEGER NOT NULL OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'),
hr_begin_tm TIME NOT NULL
OPTIONS(description='The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59.'),
hr_end_tm TIME NOT NULL
OPTIONS(description='The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (hr_id) NOT ENFORCED
) OPTIONS(description='Minor Entity - This minor dimension contains the 24 hours of a day.');