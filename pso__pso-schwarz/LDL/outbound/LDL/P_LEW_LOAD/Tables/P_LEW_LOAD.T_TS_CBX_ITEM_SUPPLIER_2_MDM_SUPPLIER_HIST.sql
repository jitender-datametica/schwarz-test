CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_supplier_2_mdm_supplier_hist (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_sup_sid BIGNUMERIC(38),
cbx_vendor_version_nr BIGNUMERIC(38),
addr_sid BIGNUMERIC(38),
sup_ship_terms_cd STRING(20) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);