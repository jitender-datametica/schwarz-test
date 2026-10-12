CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_salesforce_category (
client_id BIGNUMERIC(38,0) NOT NULL,
src_country STRING(20),
src_cust_complaint_cat_nr STRING(50) NOT NULL,
cust_complaint_cat_nr STRING(50),
cust_complaint_cat_name STRING(250),
src_name STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);