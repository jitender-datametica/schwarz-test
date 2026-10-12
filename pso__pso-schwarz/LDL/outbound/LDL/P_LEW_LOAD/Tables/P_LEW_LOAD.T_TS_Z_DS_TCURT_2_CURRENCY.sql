CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_tcurt_2_currency (
record_id INTEGER,
client_id BIGNUMERIC(38),
curr_sid BIGNUMERIC(38),
src_waers STRING(20),
curr_name STRING(100) COLLATE 'und:ci',
curr_iso_cd STRING(20),
curr_dec BIGNUMERIC(38),
factor NUMERIC(18,5),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);