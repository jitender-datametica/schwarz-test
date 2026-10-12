CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_esl_station (
client_id BIGNUMERIC(38,0),
loc_sid_store BIGNUMERIC(38,0),
src_id BIGNUMERIC(38,0),
src_code STRING(255),
src_name STRING(255),
src_company STRING(255),
src_country STRING(255),
src_region STRING(255),
src_city STRING(255),
src_filename STRING(1000),
tgt_id BIGNUMERIC(38,0),
tgt_instance STRING(255),
tgt_client_id BIGNUMERIC(38,0),
tgt_store_nr BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);