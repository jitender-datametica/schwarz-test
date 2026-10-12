CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_spaceman_item_2 AS SELECT item_sid,
 spaceman_item_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_spaceman_item_2;