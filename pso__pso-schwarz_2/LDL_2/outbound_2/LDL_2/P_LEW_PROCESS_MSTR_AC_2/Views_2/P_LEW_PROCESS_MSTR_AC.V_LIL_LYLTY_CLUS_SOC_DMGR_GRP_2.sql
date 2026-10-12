CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_lylty_clus_soc_dmgr_grp_2 (lcsd_group_id, lcsd_group_desc,
dwh_load_id, dwh_created, dwh_updated) AS SELECT lcsd_group_id,
 lcsd_group_desc,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_lylty_clus_soc_dmgr_grp_2;