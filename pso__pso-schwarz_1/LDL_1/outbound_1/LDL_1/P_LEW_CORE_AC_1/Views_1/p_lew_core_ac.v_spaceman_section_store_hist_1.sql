CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_section_store_hist_1 AS SELECT client_id,
 spaceman_section_sid,
 loc_sid_store,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_section_store_hist_1;