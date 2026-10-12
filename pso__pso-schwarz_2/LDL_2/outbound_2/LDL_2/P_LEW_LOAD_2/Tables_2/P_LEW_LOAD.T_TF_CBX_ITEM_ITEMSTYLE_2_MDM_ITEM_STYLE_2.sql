CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemstyle_2_mdm_item_style_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemstyle_cbxitem_documentref STRING(250),
cbx_item_itemstyle_cbxitem_itemstyle_uniqueid STRING(250),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
src_style_uniq_id STRING(200) COLLATE 'und:ci',
style_name STRING(300) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);