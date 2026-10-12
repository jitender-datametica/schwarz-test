CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_lil_lylty_clus_soc_dmgr_2_lil_lylty_clus_soc_dmgr_2 (
lcsd_id BIGNUMERIC(38) NOT NULL,
lcsd_desc STRING(100) COLLATE 'und:ci',
lcsd_short_desc STRING(100) COLLATE 'und:ci',
srt_cd BIGNUMERIC(38) NOT NULL,
lcsd_group_id BIGNUMERIC(38) NOT NULL,
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);