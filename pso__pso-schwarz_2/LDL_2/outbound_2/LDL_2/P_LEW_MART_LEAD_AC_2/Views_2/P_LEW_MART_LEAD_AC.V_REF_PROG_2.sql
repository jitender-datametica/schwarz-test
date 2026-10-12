CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_prog_2 (prog_sid, prog_name, prog_desc, prog_start_tmsp, prog_end_tmsp
, load_id, dwh_inserted, dwh_updated) AS SELECT prog_sid,
 prog_name,
 prog_desc,
 prog_start_tmsp,
 prog_end_tmsp,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lead.t_ref_prog_2;