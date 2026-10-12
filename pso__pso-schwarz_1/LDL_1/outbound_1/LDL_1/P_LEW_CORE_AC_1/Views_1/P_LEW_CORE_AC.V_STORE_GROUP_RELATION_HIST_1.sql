CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_store_group_relation_hist_1 (client_id, store_grp_sid, store_grp_sid_rel,
store_grp_rel_type_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 store_grp_sid,
 store_grp_sid_rel,
 store_grp_rel_type_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_store_group_relation_hist_1;