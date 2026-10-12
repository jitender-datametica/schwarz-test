CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_return_reason_descr (client_id, return_reason_cd, lang_sid, lang_cd,
return_reason_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 return_reason_cd,
 lang_sid,
 lang_cd,
 return_reason_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_return_reason_descr;