CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_item_variantquantity_2_mdm_item_sku_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_item_variantquantity_cbxitem_documentref STRING(250),
cbx_item_item_variantquantity_cbxitem_variantquantity_itemstyle_uniqueids STRING(2000),
cbx_item_item_variantquantity_cbxitem_variantquantity_itemsize_code STRING(300),
cbx_item_item_variantquantity_cbxitem_variantquantity_itemlsv_code STRING(250),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
src_style_uniqids_cd STRING(2000) COLLATE 'und:ci',
src_size_cd STRING(300) COLLATE 'und:ci',
src_variant_cd STRING(20) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);