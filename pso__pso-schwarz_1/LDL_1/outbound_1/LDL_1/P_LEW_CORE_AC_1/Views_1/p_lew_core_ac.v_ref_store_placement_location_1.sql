CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_store_placement_location_1 (client_id, store_placement_loc_cd,
store_placement_loc_descr, int_std_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 store_placement_loc_cd,
 store_placement_loc_descr,
 int_std_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_store_placement_location_1;