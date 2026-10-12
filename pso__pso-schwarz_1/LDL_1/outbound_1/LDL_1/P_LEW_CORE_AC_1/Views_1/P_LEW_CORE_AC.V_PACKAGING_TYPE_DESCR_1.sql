CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_packaging_type_descr_1 (client_id, pack_type_sid, lang_sid, lang_cd,
pack_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 pack_type_sid,
 lang_sid,
 lang_cd,
 pack_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_packaging_type_descr_1;