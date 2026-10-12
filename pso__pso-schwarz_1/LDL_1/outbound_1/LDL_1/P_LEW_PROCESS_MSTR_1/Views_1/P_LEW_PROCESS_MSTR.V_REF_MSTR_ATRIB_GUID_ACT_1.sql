CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_mstr_atrib_guid_act_1 (atrib_id, atrib_nm, guid_id, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT atrib_id,
 atrib_nm,
 guid_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_mstr_atrib_guid_1
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;