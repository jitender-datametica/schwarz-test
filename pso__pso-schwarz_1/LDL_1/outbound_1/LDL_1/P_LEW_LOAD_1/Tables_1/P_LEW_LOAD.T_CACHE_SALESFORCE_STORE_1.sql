CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_salesforce_store_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
storeid STRING(100),
store_loc_sid BIGNUMERIC(38,0),
src_store_name STRING(100),
storeid_supplyingrdc STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);