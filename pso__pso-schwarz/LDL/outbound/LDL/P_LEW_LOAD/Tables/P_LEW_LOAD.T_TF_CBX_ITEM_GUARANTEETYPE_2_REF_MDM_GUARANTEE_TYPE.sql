CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_guaranteetype_2_ref_mdm_guarantee_type (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_guaranteetype_cbxitem_guaranteetype_code STRING(250),
guarantee_type_cd STRING(100) COLLATE 'und:ci',
guarantee_type_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);