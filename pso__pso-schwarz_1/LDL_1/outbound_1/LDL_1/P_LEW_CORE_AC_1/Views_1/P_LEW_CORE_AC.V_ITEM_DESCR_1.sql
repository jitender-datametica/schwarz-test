CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_descr_1 (client_id, item_sid, lang_sid, lang_cd, item_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 lang_sid,
 lang_cd,
 item_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_descr_1;