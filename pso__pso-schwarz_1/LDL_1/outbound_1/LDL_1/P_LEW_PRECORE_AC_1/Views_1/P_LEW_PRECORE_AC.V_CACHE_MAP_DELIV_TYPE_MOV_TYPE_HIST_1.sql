CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_deliv_type_mov_type_hist_1 (client_id, bic_zmlila, order_type_cd,
mov_type_cd, deliv_type_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 bic_zmlila,
 order_type_cd,
 mov_type_cd,
 deliv_type_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_deliv_type_mov_type_hist_1;