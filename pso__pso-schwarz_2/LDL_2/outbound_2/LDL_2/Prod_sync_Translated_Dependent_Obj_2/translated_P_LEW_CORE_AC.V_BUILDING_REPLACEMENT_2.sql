CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_building_replacement_2 (client_id, building_sid, building_sid_successor,
deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_building_replacement_2;