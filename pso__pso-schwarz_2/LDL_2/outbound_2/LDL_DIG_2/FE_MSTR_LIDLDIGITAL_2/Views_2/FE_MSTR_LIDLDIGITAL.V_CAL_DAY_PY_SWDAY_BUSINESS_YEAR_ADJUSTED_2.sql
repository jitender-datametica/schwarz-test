CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_cal_day_py_swday_business_year_adjusted_2 (cal_dt, incl_cal_dt) AS
SELECT cal_dt,
 incl_cal_dt
FROM ldl_dig_lec_share.v_cal_day_py_swday_business_year_adjusted_2
WHERE bus_year_diff = 1;