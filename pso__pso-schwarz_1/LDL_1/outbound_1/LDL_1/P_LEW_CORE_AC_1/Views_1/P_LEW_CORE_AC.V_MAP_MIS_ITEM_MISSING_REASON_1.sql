CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_item_missing_reason_1 (client_id, missing_reason_cd,
mis_item_missing_reason_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 missing_reason_cd,
 mis_item_missing_reason_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_item_missing_reason_1;