CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_t002_2_report_language_1 (
record_id INTEGER,
lang_sid BIGNUMERIC(38),
src_spras STRING(20),
lang_name STRING(100) COLLATE 'und:ci',
iso_cd STRING(20),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);