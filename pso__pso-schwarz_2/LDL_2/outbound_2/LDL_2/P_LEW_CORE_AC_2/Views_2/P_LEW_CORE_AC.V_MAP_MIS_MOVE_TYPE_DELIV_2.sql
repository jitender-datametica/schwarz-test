CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_move_type_deliv_2 (client_id, order_type_cd, move_type_cd,
mis_deliv_type_id, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 order_type_cd,
 move_type_cd,
 mis_deliv_type_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_move_type_deliv_2;