CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_hour_2 (hr
OPTIONS(description='The hour of day, i.e. a number in the range from 0 to 23.'), hr_begin_tm
OPTIONS(description='The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59'),
hr_end_tm
OPTIONS(description='The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.'),
dwh_load_id OPTIONS(description='Identifier of the last run that inserted or updated this row.'), dwh_created
OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE 24 HOURS OF A DAY.`) AS SELECT hr,
 hr_begin_tm,
 hr_end_tm,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_hour_2;