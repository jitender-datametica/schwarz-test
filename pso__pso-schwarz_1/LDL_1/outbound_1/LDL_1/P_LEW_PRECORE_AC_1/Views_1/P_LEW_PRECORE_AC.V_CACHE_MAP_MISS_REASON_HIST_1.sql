CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_miss_reason_hist_1 (client_id, bic_zmlila, missing_reason_cd,
mis_item_missing_reason_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 bic_zmlila,
 missing_reason_cd,
 mis_item_missing_reason_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_miss_reason_hist_1;