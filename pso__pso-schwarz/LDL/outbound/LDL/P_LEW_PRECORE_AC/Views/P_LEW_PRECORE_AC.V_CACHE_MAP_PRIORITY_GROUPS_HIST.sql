CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_map_priority_groups_hist (client_id, bic_zmlila, prcs_grp_cd,
valid_from, prcs_grp_prio, valid_to, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 bic_zmlila,
 prcs_grp_cd,
 valid_from,
 prcs_grp_prio,
 valid_to,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_map_priority_groups_hist;