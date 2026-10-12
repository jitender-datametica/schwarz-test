CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemquantity_2_mdm_item_client_order_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_itemquantity_cbxitem_documentref STRING(250),
cbx_item_itemquantity_cbxitem_itemquantity_countrycode STRING(250),
src_item_doc_ref STRING(40),
client_id_order BIGNUMERIC(38),
client_cd STRING(20) COLLATE 'und:ci',
client_block_id_order BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);