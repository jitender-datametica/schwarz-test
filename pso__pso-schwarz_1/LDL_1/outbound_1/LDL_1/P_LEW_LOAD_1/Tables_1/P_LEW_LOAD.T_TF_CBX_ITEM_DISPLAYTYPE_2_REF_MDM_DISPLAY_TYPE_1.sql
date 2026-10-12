CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_displaytype_2_ref_mdm_display_type_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_displaytype_cbxitem_displaytype_code STRING(250),
display_type_cd STRING(20) COLLATE 'und:ci',
display_type STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);