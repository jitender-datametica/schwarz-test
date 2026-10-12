CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_lylty_clus_soc_dmgr_2 (lcsd_id, lcsd_desc, lcsd_short_desc, srt_cd
, lcsd_group_id, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT lcsd_id,
 lcsd_desc,
 lcsd_short_desc,
 srt_cd,
 lcsd_group_id,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_lylty_clus_soc_dmgr_2;