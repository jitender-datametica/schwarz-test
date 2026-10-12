CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_dyn_dsbrd_act_2 (dsbrd_id, dsbrd_act_fg, dsbrd_desc, app_id,
resort_id, deleted_fg, del_fg, dwh_valid_from, dwh_vld_from, dwh_valid_to, dwh_vld_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_dyn_dsbrd_act_2;