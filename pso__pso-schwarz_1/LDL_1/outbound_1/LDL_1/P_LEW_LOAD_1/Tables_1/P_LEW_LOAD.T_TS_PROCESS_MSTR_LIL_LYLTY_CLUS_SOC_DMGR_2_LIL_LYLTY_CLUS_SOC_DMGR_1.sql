CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_process_mstr_lil_lylty_clus_soc_dmgr_2_lil_lylty_clus_soc_dmgr_1 (
record_id STRING(1000) COLLATE 'und:ci',
lcsd_id BIGNUMERIC(38),
lcsd_desc STRING(100) COLLATE 'und:ci',
lcsd_short_desc STRING(100) COLLATE 'und:ci',
srt_cd BIGNUMERIC(38),
lcsd_group_id BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);