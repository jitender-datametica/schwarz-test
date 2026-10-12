CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_tcache_lp_delta_scrm_dim_customers_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
customer_sid BIGNUMERIC(38,0) NOT NULL,
gender_cd STRING(5) NOT NULL,
age_range_cd STRING(100) NOT NULL,
dwh_load_id INTEGER,
dwh_created DATETIME,
dwh_updated DATETIME,
PRIMARY KEY (client_id, customer_sid, gender_cd, age_range_cd) NOT ENFORCED
);