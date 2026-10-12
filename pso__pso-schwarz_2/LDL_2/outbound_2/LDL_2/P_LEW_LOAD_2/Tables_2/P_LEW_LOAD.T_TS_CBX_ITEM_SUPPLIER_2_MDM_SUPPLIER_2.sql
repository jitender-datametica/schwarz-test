CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_supplier_2_mdm_supplier_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_sup_sid BIGNUMERIC(38),
src_vendor_doc_ref STRING(20) COLLATE 'und:ci',
sup_nr BIGNUMERIC(38),
sup_name STRING(100),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);