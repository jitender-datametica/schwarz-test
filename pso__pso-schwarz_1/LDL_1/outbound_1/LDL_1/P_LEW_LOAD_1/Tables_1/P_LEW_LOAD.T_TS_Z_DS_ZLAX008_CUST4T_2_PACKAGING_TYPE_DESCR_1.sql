CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zlax008_cust4t_2_packaging_type_descr_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
pack_type_sid BIGNUMERIC(38),
lang_sid BIGNUMERIC(38),
lang_cd STRING(20),
pack_type_descr STRING(300) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);