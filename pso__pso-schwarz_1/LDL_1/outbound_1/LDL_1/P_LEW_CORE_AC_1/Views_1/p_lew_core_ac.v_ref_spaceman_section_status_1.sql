CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_spaceman_section_status_1 AS SELECT section_status_cd,
 section_status_name,
 section_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_spaceman_section_status_1;