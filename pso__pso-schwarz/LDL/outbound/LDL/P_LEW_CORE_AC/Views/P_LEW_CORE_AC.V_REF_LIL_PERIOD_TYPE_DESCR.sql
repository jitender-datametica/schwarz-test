CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_period_type_descr (period_type_id, lang_cd, period_type_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT period_type_id,
 lang_cd,
 period_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_period_type_descr;