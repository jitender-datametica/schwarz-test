CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_tcurv_2_exchange_rate_type_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_tcurv_kurst STRING(8),
src_kurst STRING(20),
src_waers STRING(40),
x_rate_type_name STRING(100) COLLATE 'und:ci',
curr_cd STRING(20),
fixed_rate_fg BIGNUMERIC(38),
special_rate_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);