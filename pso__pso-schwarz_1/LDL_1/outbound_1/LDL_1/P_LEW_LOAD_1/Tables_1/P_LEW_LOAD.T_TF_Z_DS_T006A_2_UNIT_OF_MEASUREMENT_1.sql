CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_t006a_2_unit_of_measurement_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_t006a_spras STRING(2),
z_ds_t006a_msehi STRING(6),
src_msehi STRING(20),
src_msehi_family STRING(40),
uom_name STRING(100) COLLATE 'und:ci',
uom_iso_cd STRING(20),
uom_cd_family STRING(20),
numerator_conv_si BIGNUMERIC(38),
denominator_conv_si BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);