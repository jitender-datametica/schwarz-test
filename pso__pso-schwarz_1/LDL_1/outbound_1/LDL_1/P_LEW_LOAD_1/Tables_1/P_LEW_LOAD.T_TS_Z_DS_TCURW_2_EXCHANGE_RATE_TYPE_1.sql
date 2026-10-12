CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_tcurw_2_exchange_rate_type_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
x_rate_type_sid BIGNUMERIC(38),
src_kurst STRING(20),
curr_sid BIGNUMERIC(38),
x_rate_type_name STRING(100) COLLATE 'und:ci',
curr_cd STRING(20),
fixed_rate_fg BIGNUMERIC(38),
special_rate_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);