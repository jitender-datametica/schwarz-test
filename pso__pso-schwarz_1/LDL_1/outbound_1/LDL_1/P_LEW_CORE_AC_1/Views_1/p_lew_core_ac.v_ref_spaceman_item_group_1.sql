CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_spaceman_item_group_1 AS SELECT spaceman_item_grp_sid,
 spaceman_item_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_spaceman_item_group_1;