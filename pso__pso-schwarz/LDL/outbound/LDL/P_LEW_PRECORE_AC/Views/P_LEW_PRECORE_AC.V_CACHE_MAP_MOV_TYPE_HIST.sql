CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_mov_type_hist (client_id, bic_zmlila, mov_type_cd, mov_reason_cd
, mov_type_descr, loc_type_cd, loc_type_descr, mis_sfo_type_id, mis_sfo_type_descr, map_use_cd, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 bic_zmlila,
 mov_type_cd,
 mov_reason_cd,
 mov_type_descr,
 loc_type_cd,
 loc_type_descr,
 mis_sfo_type_id,
 mis_sfo_type_descr,
 map_use_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_mov_type_hist;