CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_ident_type_1 (context_name, ident_type_cd, ident_type_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT context_name,
 ident_type_cd,
 ident_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_ident_type_1;