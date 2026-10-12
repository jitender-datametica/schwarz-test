CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_translation_2 (context, trans_id, src_trans_cd, lang_cd, orig_text
, trans_text, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT context,
 trans_id,
 src_trans_cd,
 lang_cd,
 orig_text,
 trans_text,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_translation_2;