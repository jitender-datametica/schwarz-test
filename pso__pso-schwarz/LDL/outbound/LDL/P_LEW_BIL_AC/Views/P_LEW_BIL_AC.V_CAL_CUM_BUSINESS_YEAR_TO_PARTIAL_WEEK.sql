CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_cum_business_year_to_partial_week (cy_week_part, incl_cy_week_part,
dwh_load_id, dwh_created, dwh_updated) AS SELECT cy_week_part,
 incl_cy_week_part,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_cal_cum_business_year_to_partial_week AS CAL;