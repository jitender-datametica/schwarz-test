CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_app_act_2 (app_id, app_desc, deleted_fg, dwh_valid_from,
dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_app_act_2;