CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_quarter_hour_1 (qtr_hr
OPTIONS(description='The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_1 the minute component. '),
qtr_hr_begin_tm
OPTIONS(description='The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.'),
qtr_hr_end_tm
OPTIONS(description='The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.'),
hr OPTIONS(description='The hour of day, i.e.a number in the range from 0 to 23.'), half_hr
OPTIONS(description='The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component. '),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION CONTAINS THE 96 QUARTER-HOUR INTERVALS OF A DAY.`) AS SELECT qtr_hr,
 qtr_hr_begin_tm,
 qtr_hr_end_tm,
 hr,
 half_hr,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_quarter_hour_1 AS MAIN;