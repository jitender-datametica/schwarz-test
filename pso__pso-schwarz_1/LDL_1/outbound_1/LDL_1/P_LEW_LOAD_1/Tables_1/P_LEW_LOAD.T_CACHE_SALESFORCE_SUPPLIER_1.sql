CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_salesforce_supplier_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0),
src_sup_nr STRING(100),
src_sup_name STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);