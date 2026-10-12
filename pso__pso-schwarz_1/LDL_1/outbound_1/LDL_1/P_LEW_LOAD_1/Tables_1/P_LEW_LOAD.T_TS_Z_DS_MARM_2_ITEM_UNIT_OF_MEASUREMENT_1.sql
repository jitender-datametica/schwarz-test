CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_marm_2_item_unit_of_measurement_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
uom_sid BIGNUMERIC(38),
uom_cd STRING(20),
log_var_cd STRING(20),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);