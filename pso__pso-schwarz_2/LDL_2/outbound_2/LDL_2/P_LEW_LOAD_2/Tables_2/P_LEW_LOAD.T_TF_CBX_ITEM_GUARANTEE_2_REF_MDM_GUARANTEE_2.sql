CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_guarantee_2_ref_mdm_guarantee_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_guarantee_cbxitem_guarantee_code STRING(250),
guarantee_cd STRING(100) COLLATE 'und:ci',
guarantee_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);