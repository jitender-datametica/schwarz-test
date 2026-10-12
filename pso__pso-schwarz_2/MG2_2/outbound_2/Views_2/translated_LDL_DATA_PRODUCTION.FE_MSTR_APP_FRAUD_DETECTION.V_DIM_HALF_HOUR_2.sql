CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_half_hour_2 (half_hr
OPTIONS(description='The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_2 the minute component. '),
half_hr_begin_tm
OPTIONS(description='The start time (inclusive) of the half-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:29:59.'),
half_hr_end_tm
OPTIONS(description='The end time (inclusive) of the half-hour interval. E.g. 00:29:59 for the interval from 00:00:00 to 00:29:59.'),
hr OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION CONTAINS THE 48 HALF-HOUR INTRVALS OF A DAY.`) AS SELECT half_hr,
 half_hr_begin_tm,
 half_hr_end_tm,
 hr,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_production_core_dim.t_dim_half_hour_2 AS main;