CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_client_block_2 (client_block_id, client_block_cd, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_block_id,
 client_block_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_client_block_2;