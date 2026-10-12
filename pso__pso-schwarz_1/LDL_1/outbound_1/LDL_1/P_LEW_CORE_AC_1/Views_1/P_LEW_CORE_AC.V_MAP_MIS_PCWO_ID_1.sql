CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_pcwo_id_1 (client_id, move_type_cd, move_reason_cd, move_reason_descr,
mis_pcwo_reason_id, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 move_type_cd,
 move_reason_cd,
 move_reason_descr,
 mis_pcwo_reason_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_pcwo_id_1;