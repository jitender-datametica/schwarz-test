CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_text_act_2 (text_id, tm_lvl_id, text_desc, lang_cd, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT text_id,
 tm_lvl_id,
 text_desc,
 lang_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_text_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;