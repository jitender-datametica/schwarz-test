CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_item_selection_data_detail_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(10),
mdm_item_sid BIGNUMERIC(38,0),
client_id_order BIGNUMERIC(38,0),
ldl_store_cnt BIGNUMERIC(38,0),
sales_vat_pct NUMERIC(9,5),
sales_net_euro_price NUMERIC(18,5),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);