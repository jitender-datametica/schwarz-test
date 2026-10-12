CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_spaceman_item_1 AS SELECT int_org_sid,
 spaceman_item_sid,
 spaceman_item_nr,
 active_from_dt,
 active_to_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_spaceman_item_1;