CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_0vendor_attr_2_supplier_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
sup_sid BIGNUMERIC(38),
src_lifnr STRING(20),
src_supplier_id BIGNUMERIC(38),
src_orig_supplier_nr STRING(20),
sup_name STRING(100) COLLATE 'und:ci',
tax_no_1 STRING(20),
vat_ident_no STRING(20),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);