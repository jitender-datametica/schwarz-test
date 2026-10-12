CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_package_type_1 (package_type_cd, package_type_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT package_type_cd,
 package_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_package_type_1;