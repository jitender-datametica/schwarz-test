CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_ptm_missingtype_2 (
client_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
missingtype_id BIGNUMERIC(38,0) NOT NULL,
src_wh_id BIGNUMERIC(38),
src_time_type_id BIGNUMERIC(38),
src_time_type_cd STRING(20) COLLATE 'und:ci',
time_type_short_descr STRING(20) COLLATE 'und:ci',
time_type_descr STRING(100) COLLATE 'und:ci',
presence_fg BIGNUMERIC(38),
performance_relevant_fg BIGNUMERIC(38),
source_system STRING(20) COLLATE 'und:ci',
file_record_id BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);