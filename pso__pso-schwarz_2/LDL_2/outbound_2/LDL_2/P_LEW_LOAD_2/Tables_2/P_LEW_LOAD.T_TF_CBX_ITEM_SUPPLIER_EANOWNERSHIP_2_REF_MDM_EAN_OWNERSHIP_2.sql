CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_supplier_eanownership_2_ref_mdm_ean_ownership_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_supplier_eanownership_cbxitem_supplier_eanownership_code STRING(250),
ean_ownership_cd STRING(20) COLLATE 'und:ci',
ean_ownership STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);