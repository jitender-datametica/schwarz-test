CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_lylty_clus_soc_dmgr (
lcsd_id BIGNUMERIC(38,0) NOT NULL,
lcsd_desc STRING(800),
lcsd_short_desc STRING(800),
srt_cd BIGNUMERIC(38,0) NOT NULL,
lcsd_group_id BIGNUMERIC(38,0) NOT NULL,
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);