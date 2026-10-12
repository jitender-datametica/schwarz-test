CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cal_cum_partial_week_to_date_2 (cal_dt, incl_cal_dt, dwh_load_id, dwh_created
, dwh_updated) AS SELECT *
FROM ldl_p_lew_bil_ac.v_cal_cum_partial_week_to_date_2 AS CAL;