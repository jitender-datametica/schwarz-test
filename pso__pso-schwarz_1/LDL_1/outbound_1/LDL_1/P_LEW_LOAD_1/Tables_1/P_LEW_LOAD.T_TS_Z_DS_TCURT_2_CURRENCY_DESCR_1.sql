CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_tcurt_2_currency_descr_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
curr_sid BIGNUMERIC(38),
lang_sid BIGNUMERIC(38),
curr_cd STRING(20),
lang_cd STRING(20),
curr_descr_short STRING(100) COLLATE 'und:ci',
curr_descr_long STRING(300) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);