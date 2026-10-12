CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_wrf_brands_t_2_brand_descr_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
brand_sid BIGNUMERIC(38),
lang_sid BIGNUMERIC(38),
lang_cd STRING(20),
brand_descr STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);