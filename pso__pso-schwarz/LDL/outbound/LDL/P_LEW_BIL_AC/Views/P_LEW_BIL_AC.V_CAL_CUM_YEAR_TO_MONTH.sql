CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_cum_year_to_month (cy_month, incl_cy_month, dwh_load_id, dwh_created,
dwh_updated) AS SELECT cy_month,
 incl_cy_month,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_cal_cum_year_to_month AS CAL;