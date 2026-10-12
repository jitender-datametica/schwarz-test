CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cal_cum_year_to_month_1 (cy_month, incl_cy_month, dwh_load_id, dwh_created
, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cal_cum_year_to_month_1 AS CAL;