CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_building_status_2 (client_id, building_status_id, building_status_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_ref_building_status_2;