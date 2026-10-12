CREATE OR REPLACE VIEW fe_mstr_master.v_dim_hour_1 (hr
OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'), hr_begin_tm
OPTIONS(description='The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59.'),
hr_end_tm
OPTIONS(description='The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION CONTAINS THE 24 HOURS OF A DAY.`) AS SELECT hr,
 hr_begin_tm,
 hr_end_tm,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_hour_1 AS MAIN;