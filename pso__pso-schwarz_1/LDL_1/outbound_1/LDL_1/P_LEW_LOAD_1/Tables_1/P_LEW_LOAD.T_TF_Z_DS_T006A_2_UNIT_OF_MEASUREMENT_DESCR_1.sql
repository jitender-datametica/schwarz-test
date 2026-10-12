CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_t006a_2_unit_of_measurement_descr_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_t006a_spras STRING(2),
z_ds_t006a_msehi STRING(6),
src_msehi STRING(40),
src_spras STRING(40),
uom_cd STRING(20),
lang_cd STRING(20),
uom_descr_short STRING(100) COLLATE 'und:ci',
uom_descr_long STRING(300) COLLATE 'und:ci',
uom_descr_ext_3ch STRING(100) COLLATE 'und:ci',
uom_descr_ext_6ch STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);