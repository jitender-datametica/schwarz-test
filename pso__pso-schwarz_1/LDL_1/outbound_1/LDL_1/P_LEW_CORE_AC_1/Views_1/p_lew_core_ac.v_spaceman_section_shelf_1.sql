CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_section_shelf_1 AS SELECT shelf_sid,
 spaceman_section_sid,
 src_section_nr,
 src_shelf_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_section_shelf_1;