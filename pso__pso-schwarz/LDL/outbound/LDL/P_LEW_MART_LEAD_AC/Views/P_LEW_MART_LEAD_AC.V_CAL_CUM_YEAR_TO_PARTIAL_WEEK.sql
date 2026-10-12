CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cal_cum_year_to_partial_week (cy_week_part, incl_cy_week_part,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cal_cum_year_to_partial_week AS CAL;