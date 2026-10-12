CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_move_type_1 (client_id, move_type_cd, move_type_descr, move_reason_cd,
wh_store_mark, wh_store_label, mis_sfo_type_id, mis_sfo_type_descr, map_use_id, dwh_load_id, dwh_created, dwh_updated)
AS SELECT client_id,
 move_type_cd,
 move_type_descr,
 move_reason_cd,
 wh_store_mark,
 wh_store_label,
 mis_sfo_type_id,
 mis_sfo_type_descr,
 map_use_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_move_type_1;