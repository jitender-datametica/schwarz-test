CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_building (client_id, building_sid, src_object_no, building_type_id,
building_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 building_sid,
 src_object_no,
 building_type_id,
 building_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_building AS V;