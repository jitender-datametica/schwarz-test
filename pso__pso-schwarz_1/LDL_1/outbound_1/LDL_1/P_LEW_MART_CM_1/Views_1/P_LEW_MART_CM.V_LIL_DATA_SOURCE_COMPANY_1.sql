CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_data_source_company_1 (dsc_nr, dsc_name, dsc_type_cd) AS SELECT dsc_nr,
 dsc_name,
 dsc_type_cd
FROM ldl_p_lew_core_ac.v_ref_lil_data_source_company_1;