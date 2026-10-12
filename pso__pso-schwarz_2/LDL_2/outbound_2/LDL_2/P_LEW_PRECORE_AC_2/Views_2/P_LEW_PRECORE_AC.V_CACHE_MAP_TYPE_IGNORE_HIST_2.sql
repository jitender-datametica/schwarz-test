CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_type_ignore_hist_2 (client_id, bic_zmlila, itm_type_id,
itm_type_group_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 bic_zmlila,
 itm_type_id,
 itm_type_group_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_type_ignore_hist_2;