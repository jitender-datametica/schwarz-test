CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_esl_solum_lifecycle (
src_label_code STRING(255) NOT NULL,
src_created DATETIME,
src_last_modified DATETIME,
src_station_code STRING(255),
src_template_manual INTEGER,
src_filename STRING(1000),
tgt_instance STRING(255),
tgt_label_code STRING(255) NOT NULL,
tgt_created DATETIME,
tgt_last_modified DATETIME,
tgt_client_id BIGNUMERIC(38,0),
tgt_orig_store_nr BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);