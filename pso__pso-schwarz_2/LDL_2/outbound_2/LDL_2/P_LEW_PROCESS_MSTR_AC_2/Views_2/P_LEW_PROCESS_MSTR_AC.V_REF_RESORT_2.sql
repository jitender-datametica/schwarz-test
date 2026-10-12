CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_resort_2 (resort_id, resort_desc, resort_ord, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT resort_id,
 resort_desc,
 resort_ord,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_resort_2;