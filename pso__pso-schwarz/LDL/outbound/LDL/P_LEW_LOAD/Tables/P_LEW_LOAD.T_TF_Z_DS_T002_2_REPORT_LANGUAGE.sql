CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_t002_2_report_language (
src_spras STRING(20),
lang_name STRING(100) COLLATE 'und:ci',
z_ds_t002_spras STRING(2),
iso_cd STRING(20),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);