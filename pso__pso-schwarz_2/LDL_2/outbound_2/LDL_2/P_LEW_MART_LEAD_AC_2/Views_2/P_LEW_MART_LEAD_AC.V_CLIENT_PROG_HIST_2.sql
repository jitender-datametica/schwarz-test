CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_client_prog_hist_2 (client_id, prog_sid, prog_start_tmsp, prog_end_tmsp,
full_client_start_tmsp, full_client_end_tmsp, client_repo_start_tmsp, load_id, dwh_inserted, dwh_updated) AS SELECT
 client_id,
 prog_sid,
 prog_start_tmsp,
 prog_end_tmsp,
 full_client_start_tmsp,
 full_client_end_tmsp,
 client_repo_start_tmsp,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lead.t_client_prog_hist_2;