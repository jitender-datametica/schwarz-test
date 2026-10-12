CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_section AS SELECT spaceman_section_sid,
 int_org_sid,
 src_section_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_section;