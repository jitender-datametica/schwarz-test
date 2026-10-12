CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_shippingterms_2_mdm_ship_terms (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_shippingterms_cbxitem_shippingterms_completiontype_code STRING(250),
cbx_item_shippingterms_cbxitem_shippingterms_incoterms_code STRING(250),
cbx_item_shippingterms_cbxitem_shippingterms_invoicecurrency STRING(250),
src_completion_type_cd STRING(20) COLLATE 'und:ci',
src_incoterms_cd STRING(20) COLLATE 'und:ci',
curr_cd_invoice STRING(20) COLLATE 'und:ci',
curr_iso_cd STRING(40),
ship_to STRING(100) COLLATE 'und:ci',
ship_terms STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);