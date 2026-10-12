CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_advert_media_group_map_hist (client_id, country_cd, adv_medium_id,
adv_media_grp_id, display_fg, display_seq, file_name, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created
, dwh_updated) AS SELECT client_id,
 country_cd,
 adv_medium_id,
 adv_media_grp_id,
 display_fg,
 display_seq,
 file_name,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_advert_media_group_map_hist;