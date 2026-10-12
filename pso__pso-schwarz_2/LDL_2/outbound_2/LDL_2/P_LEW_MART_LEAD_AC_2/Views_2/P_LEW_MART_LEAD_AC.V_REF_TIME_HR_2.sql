CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_time_hr_2 AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_time_hr_2 AS RT
GROUP BY time_hour_id,
 time_hour_display;