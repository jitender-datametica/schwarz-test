/*
    When           Who               What
    2021-04-16     Oguzhan Guenes    Migration to Snowflake.
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_sys_country_timezone (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci',
schedule_zone_id BIGNUMERIC(38) NOT NULL,
utc_cd STRING(6) COLLATE 'und:ci' NOT NULL,
td_timezone STRING(130) COLLATE 'und:ci',
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
trans_start_time TIME NOT NULL,
trans_end_time TIME NOT NULL,
trans_start_time_scnd TIME NOT NULL,
trans_end_time_scnd TIME NOT NULL,
trans_flag BIGNUMERIC(38) NOT NULL
);