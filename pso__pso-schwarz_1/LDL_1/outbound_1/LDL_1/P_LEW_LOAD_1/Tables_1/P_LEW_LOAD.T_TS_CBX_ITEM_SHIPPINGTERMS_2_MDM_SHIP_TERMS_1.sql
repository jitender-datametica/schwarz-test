CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_shippingterms_2_mdm_ship_terms_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
ship_terms_sid BIGNUMERIC(38),
src_completion_type_cd STRING(20) COLLATE 'und:ci',
src_incoterms_cd STRING(20) COLLATE 'und:ci',
curr_sid_invoice BIGNUMERIC(38),
curr_cd_invoice STRING(20) COLLATE 'und:ci',
ship_to STRING(100) COLLATE 'und:ci',
ship_terms STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);