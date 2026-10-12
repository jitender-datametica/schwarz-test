CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted (cal_dt, bus_year_diff, incl_cal_dt,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_bil.t_cal_day_py_business_year_adjusted AS CALDAY;