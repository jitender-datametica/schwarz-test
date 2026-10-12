CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zmmx_coneg_cntry_2_supplier_coneg_country_hist_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
sup_sid BIGNUMERIC(38),
country_sid_conegot BIGNUMERIC(38),
country_cd_conegot STRING(20),
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);