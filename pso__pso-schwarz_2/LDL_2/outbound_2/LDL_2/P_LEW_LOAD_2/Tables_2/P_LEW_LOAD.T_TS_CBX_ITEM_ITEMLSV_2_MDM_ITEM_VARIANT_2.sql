CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_itemlsv_2_mdm_item_variant_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_item_variant_sid BIGNUMERIC(38),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
src_variant_cd STRING(20) COLLATE 'und:ci',
variant_name STRING(300) COLLATE 'und:ci',
mdm_item_sid BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);