CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_sap_item_property_identifier_2 (client_id, identifier_id, identifier_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 identifier_id,
 identifier_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_sap_item_property_identifier_2;