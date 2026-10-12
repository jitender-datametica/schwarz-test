CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_cbxitem_2_mdm_item_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_cbxitem_documentref STRING(250),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
mdm_item_name STRING(100),
item_ian BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);