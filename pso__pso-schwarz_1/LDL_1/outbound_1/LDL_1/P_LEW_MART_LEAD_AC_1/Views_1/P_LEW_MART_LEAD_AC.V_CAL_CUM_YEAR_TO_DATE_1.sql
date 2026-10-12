CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cal_cum_year_to_date_1 (cal_dt, incl_cal_dt, dwh_load_id, dwh_created,
dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cal_cum_year_to_date_1 AS CAL;