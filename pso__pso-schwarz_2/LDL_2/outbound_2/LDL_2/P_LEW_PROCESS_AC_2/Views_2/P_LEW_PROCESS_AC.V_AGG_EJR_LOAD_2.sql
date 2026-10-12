CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_agg_ejr_load_2 (client_id, loc_sid, aspect_id, dwh_cal_dt, scenario, core,
solace, dayend_completion, ladequote, ladequote_solace) AS SELECT client_id,
 loc_sid,
 aspect_id,
 dwh_cal_dt,
 scenario,
 core,
 solace,
 dayend_completion,
 ladequote,
 ladequote_solace
FROM ldl_p_lew_process.t_agg_ejr_load_2;