CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_property_relation_hist_2 (client_id, item_sid,
item_property_sid, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 item_sid,
 item_property_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_property_relation_hist_2;