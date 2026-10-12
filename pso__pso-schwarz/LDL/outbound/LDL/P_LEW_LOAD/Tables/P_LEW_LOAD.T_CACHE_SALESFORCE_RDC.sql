CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_salesforce_rdc (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0),
storeid_supplyingrdc STRING(100),
src_wh_name STRING(100),
src_wh_acct_name STRING(100),
src_wh_descr STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);