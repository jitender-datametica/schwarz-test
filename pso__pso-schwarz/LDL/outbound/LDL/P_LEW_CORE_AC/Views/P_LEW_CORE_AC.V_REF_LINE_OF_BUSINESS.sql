CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_line_of_business (lob_cd, lob_name, dwh_load_id, dwh_created, dwh_updated
) AS SELECT lob_cd,
 lob_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_line_of_business;