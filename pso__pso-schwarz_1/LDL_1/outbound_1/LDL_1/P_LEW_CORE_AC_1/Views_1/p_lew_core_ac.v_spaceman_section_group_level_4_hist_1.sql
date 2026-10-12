CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_section_group_level_4_hist_1 AS SELECT section_group_level_4_nr,
 section_group_level_3_nr,
 section_group_level_4_name,
 int_org_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_section_group_level_4_hist_1;