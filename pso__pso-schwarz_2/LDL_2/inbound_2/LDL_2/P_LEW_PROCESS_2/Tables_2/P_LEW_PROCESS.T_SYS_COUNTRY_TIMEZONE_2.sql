/*
    When           Who               What
    2021-04-16     Oguzhan Guenes    Migration to Snowflake.
*/

CREATE TABLE p_lew_process.t_sys_country_timezone_2
     (
      client_id number(38) NOT NULL,
      country_iso_cd VARCHAR(3) COLLATE 'en-ci',
      schedule_zone_id number(38) NOT NULL,
      utc_cd VARCHAR(6) COLLATE 'en-ci' NOT NULL,
      td_timezone VARCHAR(130) COLLATE 'en-ci',
      dat_valid_from DATE  NOT NULL,
      dat_valid_until DATE NOT NULL,
      trans_start_time TIME(0) NOT NULL,
      trans_end_time TIME(0) NOT NULL,
      trans_start_time_scnd TIME(0) NOT NULL,
      trans_end_time_scnd TIME(0) NOT NULL,
      trans_flag number(38) NOT NULL,
UNIQUE ( client_id ,country_iso_cd ,schedule_zone_id ,dat_valid_until )
       );