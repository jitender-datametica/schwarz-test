CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lil_translation_2_lil_translation_2 (
record_id STRING(1000) COLLATE 'und:ci',
context STRING(100) COLLATE 'und:ci',
trans_id BIGNUMERIC(38),
src_trans_cd STRING(100),
lang_cd STRING(2) COLLATE 'und:ci',
orig_text STRING(100),
trans_text STRING(100),
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