CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_upto_current_hour_indicator_1 (upto_current_hour_ind) AS
SELECT DISTINCT CASE
  WHEN EXTRACT(HOUR FROM CURRENT_TIME) < hour_24
  THEN 1
  ELSE 0
  END AS upto_current_hour_ind
FROM ldl_dig_lec_share.v_dim_cal_time_1;