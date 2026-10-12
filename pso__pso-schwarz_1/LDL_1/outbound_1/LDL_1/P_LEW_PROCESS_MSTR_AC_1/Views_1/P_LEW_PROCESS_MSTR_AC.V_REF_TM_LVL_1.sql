CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_tm_lvl_1 (tm_lvl_id, tm_lvl_desc, deleted_fg, dwh_valid_from,
dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT tm_lvl_id,
 tm_lvl_desc,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_tm_lvl_1;