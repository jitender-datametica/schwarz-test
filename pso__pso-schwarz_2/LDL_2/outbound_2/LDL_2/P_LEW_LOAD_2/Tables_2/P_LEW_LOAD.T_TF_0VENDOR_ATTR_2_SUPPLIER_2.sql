CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0vendor_attr_2_supplier_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
vendor_attr_lifnr STRING(20),
src_lifnr STRING(20),
src_supplier_id BIGNUMERIC(38),
src_orig_supplier_nr STRING(20),
sup_name STRING(100) COLLATE 'und:ci',
tax_no_1 STRING(20),
vat_ident_no STRING(20),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);