CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_property (client_id, item_property_sid,
src_item_property_id, src_atwrt, item_property_cd, item_property_int_name, item_property_local_name, item_property_descr
, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_property_sid,
 src_item_property_id,
 src_atwrt,
 item_property_cd,
 item_property_int_name,
 item_property_local_name,
 item_property_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_property;