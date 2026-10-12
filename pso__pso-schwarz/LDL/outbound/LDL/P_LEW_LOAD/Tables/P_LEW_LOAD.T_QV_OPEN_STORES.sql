CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_qv_open_stores (
client_id BIGNUMERIC(38,0) NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) OPTIONS(description='QuickView load table : Open stores (any store with a transaction in the last 13 months)');