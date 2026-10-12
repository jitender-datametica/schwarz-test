CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_case_composition_1 (mdm_case_composition_cd, mdm_case_composition_txt,
subcase_size_qty, mdm_case_composition_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT mdm_case_composition_cd,
 mdm_case_composition_txt,
 subcase_size_qty,
 mdm_case_composition_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_case_composition_1;