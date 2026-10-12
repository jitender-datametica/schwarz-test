CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_location_building_hist_2 (client_id, loc_sid, building_sid, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_location_building_hist_2 AS V;