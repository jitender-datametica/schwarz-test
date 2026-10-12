CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_hour_1 (hour_of_day, upto_current_hour_ind, hour_range) AS
SELECT DISTINCT hour_of_day,
 IF(EXTRACT(HOUR FROM TIME_ADD(CURRENT_TIME, INTERVAL 1 HOUR)) = 0, 0, CASE
   WHEN EXTRACT(HOUR FROM TIME_ADD(CURRENT_TIME, INTERVAL 1 HOUR)) < hour_of_day
   THEN 1
   ELSE 0
   END) AS upto_current_hour_ind,
 CONCAT(RIGHT(CONCAT('00', hour_24), 2), '-', RIGHT(CONCAT('00', hour_of_day), 2)) AS hour_range
FROM ldl_dig_lec_share.v_dim_cal_time_1 AS TM;