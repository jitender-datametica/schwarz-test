CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_transformation_ly_same_day (cal_dt, cal_dt_prev_1y) AS SELECT
DISTINCT cal_dt,
 cal_dt_prev_1y
FROM ldl_dig_lec_share.v_dim_cal_day;