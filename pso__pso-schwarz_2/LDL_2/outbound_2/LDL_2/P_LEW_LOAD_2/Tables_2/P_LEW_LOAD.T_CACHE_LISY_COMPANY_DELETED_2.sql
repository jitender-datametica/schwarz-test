CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_lisy_company_deleted_2 (
src_deleted STRING(10),
src_id STRING(250) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);