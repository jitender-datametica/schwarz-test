CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemsize_2_mdm_item_size_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemsize_cbxitem_documentref STRING(250),
cbx_item_itemsize_cbxitem_itemsize_code STRING(250),
src_item_doc_ref STRING(40),
src_size_cd STRING(100),
size_name STRING(300) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);