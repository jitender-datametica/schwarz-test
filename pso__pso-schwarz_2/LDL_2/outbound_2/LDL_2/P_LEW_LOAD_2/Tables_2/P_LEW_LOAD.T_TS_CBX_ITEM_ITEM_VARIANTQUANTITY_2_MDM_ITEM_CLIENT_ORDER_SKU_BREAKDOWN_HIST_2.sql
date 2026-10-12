CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_item_variantquantity_2_mdm_item_client_order_sku_breakdown_hist_2
(
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_item_sid BIGNUMERIC(38),
client_id_order BIGNUMERIC(38),
mdm_item_sku_sid BIGNUMERIC(38),
order_sku_qty BIGNUMERIC(38),
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