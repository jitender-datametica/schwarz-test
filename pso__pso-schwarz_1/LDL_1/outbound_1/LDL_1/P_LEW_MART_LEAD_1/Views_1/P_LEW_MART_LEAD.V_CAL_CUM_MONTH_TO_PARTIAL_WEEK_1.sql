CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cal_cum_month_to_partial_week_1 (cy_week_part, incl_cy_week_part, dwh_load_id
, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_bil_ac.v_cal_cum_month_to_partial_week_1 AS CAL;