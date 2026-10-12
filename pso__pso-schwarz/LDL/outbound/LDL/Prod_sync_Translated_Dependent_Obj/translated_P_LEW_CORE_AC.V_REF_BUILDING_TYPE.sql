CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_building_type (client_id, building_type_id, building_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_ref_building_type;