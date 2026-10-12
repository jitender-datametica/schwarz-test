CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_pcwo_id_hist (client_id, bic_zmlila, pcwo_reason_id, mov_type_cd
, mov_reason_cd, mov_reason_descr, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 bic_zmlila,
 pcwo_reason_id,
 mov_type_cd,
 mov_reason_cd,
 mov_reason_descr,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_pcwo_id_hist;