CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_lp_dim_customers (
iso_country_code STRING(40),
src_customerid STRING(100),
gender_cd STRING(5),
age_range_cd STRING(100),
dwh_load_id INTEGER,
dwh_created DATETIME,
dwh_updated DATETIME
);