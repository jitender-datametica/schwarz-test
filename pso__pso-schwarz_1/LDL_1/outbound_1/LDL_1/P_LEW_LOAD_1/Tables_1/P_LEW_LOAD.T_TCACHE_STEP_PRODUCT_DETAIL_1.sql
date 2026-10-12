CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_step_product_detail_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(10),
selectionitem_id STRING(20),
client_id_order BIGNUMERIC(38,0),
sales_vat_pct NUMERIC(9,5),
kfl_large_store_cnt BIGNUMERIC(38,0),
kfl_small_store_cnt BIGNUMERIC(38,0),
sales_gross_euro_price NUMERIC(18,5),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);