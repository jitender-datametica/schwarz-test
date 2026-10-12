CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_step_product (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(10),
item_ian BIGNUMERIC(38,0),
range_plan_cd STRING(20),
item_selection_nr STRING(20),
step_item_nr STRING(20),
online_store_data_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);