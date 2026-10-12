CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_tcurc_2_currency_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_tcurc_waers STRING(10),
src_waers STRING(20),
curr_name STRING(100) COLLATE 'und:ci',
curr_iso_cd STRING(20),
curr_dec BIGNUMERIC(38),
factor NUMERIC(18,5),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);