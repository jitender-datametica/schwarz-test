CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_delivery_type_descr_2 (client_id, delivery_type_id, lang_sid, lang_cd,
delivery_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 delivery_type_id,
 lang_sid,
 lang_cd,
 delivery_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_delivery_type_descr_2;