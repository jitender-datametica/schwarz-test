CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_tcurt_2_currency_descr_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_tcurt_spras STRING(2),
z_ds_tcurt_waers STRING(10),
src_waers STRING(40),
src_spras STRING(40),
curr_cd STRING(20),
lang_cd STRING(20),
curr_descr_short STRING(100) COLLATE 'und:ci',
curr_descr_long STRING(300) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);