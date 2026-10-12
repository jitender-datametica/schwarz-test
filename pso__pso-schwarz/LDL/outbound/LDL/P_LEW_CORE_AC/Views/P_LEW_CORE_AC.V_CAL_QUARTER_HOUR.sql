CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_quarter_hour (qtr_hr
OPTIONS(description='The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm the minute component. '),
half_hr
OPTIONS(description='The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm the minute component. '),
hr OPTIONS(description='The hour of day, i.e. a number in the range from 0 to 23.'), qtr_hr_begin_tm
OPTIONS(description='The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.'),
qtr_hr_end_tm
OPTIONS(description='The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.'),
dwh_load_id OPTIONS(description='Identifier of the last run that inserted or updated this row.'), dwh_created
OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE 96 QUARTER-HOUR INTERVALS OF A DAY.`) AS SELECT qtr_hr,
 half_hr,
 hr,
 qtr_hr_begin_tm,
 qtr_hr_end_tm,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_quarter_hour;