CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_lylty_clus_soc_dmgr_grp_2 (
lcsd_group_id BIGNUMERIC(38,0) NOT NULL,
lcsd_group_desc STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);