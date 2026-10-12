CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_ejr_load_1 (client_id, loc_sid_store_move_to, aspect_id, dwh_cal_dt,
scenario, core, solace, dayend_completion, ladequote, ladequote_solace) AS SELECT client_id,
 loc_sid AS loc_sid_store_move_to,
 aspect_id,
 dwh_cal_dt,
 scenario,
 core,
 solace,
 dayend_completion,
 ladequote,
 ladequote_solace
FROM ldl_p_lew_process.t_agg_ejr_load_1
WHERE store_open_fg = 1;