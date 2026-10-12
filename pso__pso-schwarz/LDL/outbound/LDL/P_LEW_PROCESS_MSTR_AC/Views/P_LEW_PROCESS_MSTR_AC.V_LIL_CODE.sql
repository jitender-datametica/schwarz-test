CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_code (main_code, sub_code, key_field, val, dwh_load_id,
dwh_created, dwh_updated) AS SELECT main_code,
 sub_code,
 key_field,
 val,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_code;