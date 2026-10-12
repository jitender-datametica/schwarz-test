CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_cust_session (
customer_sid BIGNUMERIC(38,0) NOT NULL,
src_customerid STRING(250) NOT NULL,
src_app_session_id BIGNUMERIC(38,0),
subsession_id_index BIGNUMERIC(38,0) NOT NULL,
date_key DATE,
app_version_os_nr STRING(100),
app_version_nr STRING(100),
country STRING(5),
subsession_start_date_time DATETIME NOT NULL,
subsession_end_date_time DATETIME NOT NULL,
metric_value BIGNUMERIC(38,0) NOT NULL,
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);