CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_custinfo_events_1 (
client_id BIGNUMERIC(38,0),
event_id STRING(200),
country_code STRING(10),
src_customerid STRING(100),
data_type STRING(100),
sso_client_app_id STRING(200),
loyalty_cards_loyalty_id STRING(100),
loyalty_cards_type STRING(100),
source_name STRING(100),
date_key DATE,
valid_time_key DATETIME,
l1_insert_time_key DATETIME,
scrm_extract_timestamp DATETIME,
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);