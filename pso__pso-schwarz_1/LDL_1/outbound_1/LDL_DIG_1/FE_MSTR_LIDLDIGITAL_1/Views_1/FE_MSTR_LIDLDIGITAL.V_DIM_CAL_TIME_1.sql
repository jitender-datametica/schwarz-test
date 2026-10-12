CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_time_1 (cal_tm, second_of_day, second_of_hour,
second_of_minute, minute_of_day, minute_of_hour, hour_of_day, hour_24, hour_24_desc, hour_12, hour_12_desc, am_pm_ind,
upto_current_hour_ind) AS SELECT cal_tm,
 second_of_day,
 second_of_hour,
 second_of_minute,
 minute_of_day,
 minute_of_hour,
 hour_of_day,
 hour_24,
 hour_24_desc,
 hour_12,
 hour_12_desc,
 am_pm_ind,
 IF(EXTRACT(HOUR FROM TIME_ADD(CURRENT_TIME, INTERVAL 1 HOUR)) = 0, 0, CASE
   WHEN EXTRACT(HOUR FROM TIME_ADD(CURRENT_TIME, INTERVAL 1 HOUR)) < hour_of_day
   THEN 1
   ELSE 0
   END) AS upto_current_hour_ind
FROM ldl_dig_lec_share.v_dim_cal_time_1;