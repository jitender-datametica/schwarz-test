CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_section_group_level_1_hist_2 AS SELECT section_group_level_1_nr,
 int_org_sid,
 section_group_level_1_name,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_section_group_level_1_hist_2;