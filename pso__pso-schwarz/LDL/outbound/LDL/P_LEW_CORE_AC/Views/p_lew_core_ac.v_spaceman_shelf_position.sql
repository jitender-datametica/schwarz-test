CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_shelf_position AS SELECT shelf_position_sid,
 shelf_sid,
 src_section_nr,
 src_shelf_nr,
 src_position_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_shelf_position;