CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_supplier_shippingterms_2_ref_mdm_sup_ship_terms_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_supplier_shippingterms_cbxitem_supplier_shippingterms_code STRING(250),
sup_ship_terms_cd STRING(20) COLLATE 'und:ci',
sup_ship_terms STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);