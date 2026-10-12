CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_cum_month_to_date (cal_dt, incl_cal_dt, dwh_load_id, dwh_created,
dwh_updated) AS SELECT cal_dt,
 incl_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_cal_cum_month_to_date AS CAL;