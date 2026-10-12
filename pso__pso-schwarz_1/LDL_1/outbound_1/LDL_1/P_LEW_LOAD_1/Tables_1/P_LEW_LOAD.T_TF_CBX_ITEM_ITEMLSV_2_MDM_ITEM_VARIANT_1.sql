CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemlsv_2_mdm_item_variant_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemlsv_cbxitem_documentref STRING(250),
cbx_item_itemlsv_cbxitem_itemlsv_code STRING(250),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
src_variant_cd STRING(20) COLLATE 'und:ci',
variant_name STRING(300) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);