CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_itemsize_2_mdm_item_size_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_item_size_sid BIGNUMERIC(38),
src_item_doc_ref STRING(20) COLLATE 'und:ci',
src_size_cd STRING(100) COLLATE 'und:ci',
size_name STRING(300) COLLATE 'und:ci',
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