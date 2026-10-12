CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_mean_2_item_gtin (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
uom_sid BIGNUMERIC(38),
src_lfnum STRING(20),
uom_cd STRING(20),
gtin STRING(20),
gtin_type_cd STRING(20),
main_gtin_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);