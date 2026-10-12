CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_dyn_dsbrd (dsbrd_id, dsbrd_act_fg, dsbrd_desc, app_id, resort_id
, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT dsbrd_id,
 dsbrd_act_fg,
 dsbrd_desc,
 app_id,
 resort_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_dyn_dsbrd;