CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_lisy_account_deleted_1 (
src_deleted STRING(10),
src_accountid STRING(250) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);