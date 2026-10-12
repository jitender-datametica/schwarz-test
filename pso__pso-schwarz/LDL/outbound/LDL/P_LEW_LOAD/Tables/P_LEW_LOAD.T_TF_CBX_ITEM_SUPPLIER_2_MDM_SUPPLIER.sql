CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_supplier_2_mdm_supplier (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_supplier_cbxitem_supplier_documentref STRING(250),
src_vendor_doc_ref STRING(20) COLLATE 'und:ci',
sup_nr BIGNUMERIC(38),
sup_name STRING(100),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);