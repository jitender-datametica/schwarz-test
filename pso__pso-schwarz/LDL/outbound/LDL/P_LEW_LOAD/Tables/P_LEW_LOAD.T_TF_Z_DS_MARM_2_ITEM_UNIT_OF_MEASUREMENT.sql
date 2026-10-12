CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_marm_2_item_unit_of_measurement (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_marm_matnr STRING(36),
z_ds_marm_meinh STRING(6),
src_matnr STRING(40),
src_msehi STRING(40),
uom_cd STRING(20),
log_var_cd STRING(20),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);