CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_lift_dm_retailer_gd_sort_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
rtl_id BIGNUMERIC(38,0) NOT NULL,
rtl_desc STRING(128) COLLATE 'und:ci',
rtl_desc_en STRING(128) COLLATE 'und:ci',
rtl_tp_id BIGNUMERIC(38,0) NOT NULL,
clnt_rtl_srt_cd BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);