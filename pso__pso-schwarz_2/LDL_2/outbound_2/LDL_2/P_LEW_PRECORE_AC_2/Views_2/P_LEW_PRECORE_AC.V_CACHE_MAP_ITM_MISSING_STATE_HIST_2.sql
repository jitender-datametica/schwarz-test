CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_itm_missing_state_hist_2 (client_id, bic_zmlila, itm_state_bges_id
, itm_missing_state, itm_missing_reason_cd, item_status_pp_mis, end_cd_pp_mis, deleted_fg, dwh_valid_from, dwh_valid_to
, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 bic_zmlila,
 itm_state_bges_id,
 itm_missing_state,
 itm_missing_reason_cd,
 item_status_pp_mis,
 end_cd_pp_mis,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_itm_missing_state_hist_2;