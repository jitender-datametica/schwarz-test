CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_data_source_company_2 (dsc_nr, dsc_name, dsc_type_cd, dwh_load_id,
dwh_created, dwh_updated) AS SELECT dsc_nr,
 dsc_name,
 dsc_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_data_source_company_2;