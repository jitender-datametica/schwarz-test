/*
    When                Who                What
    2021-04-16          Oguzhan Guenes     Migration to Snowflake.
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_sys_country_timezone (client_id, country_iso_cd, schedule_zone_id, utc_cd
, td_timezone, dat_valid_from, dat_valid_until, trans_start_time, trans_end_time, trans_start_time_scnd,
trans_end_time_scnd, trans_flag) AS SELECT client_id,
 country_iso_cd,
 schedule_zone_id,
 utc_cd,
 td_timezone,
 dat_valid_from,
 dat_valid_until,
 trans_start_time,
 trans_end_time,
 trans_start_time_scnd,
 trans_end_time_scnd,
 trans_flag
FROM ldl_p_lew_process.t_sys_country_timezone;