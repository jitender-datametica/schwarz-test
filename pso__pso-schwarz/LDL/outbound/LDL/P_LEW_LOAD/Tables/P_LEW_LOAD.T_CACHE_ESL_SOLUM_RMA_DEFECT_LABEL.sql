CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_esl_solum_rma_defect_label (
src_id BIGNUMERIC(38,0),
src_creation_date DATETIME,
src_defect_reason STRING(255),
src_label_code STRING(100),
src_station_code STRING(255),
src_db_host STRING(255),
src_filename STRING(1000),
tgt_id BIGNUMERIC(38,0),
tgt_instance STRING(255),
tgt_creation_date DATETIME,
tgt_defect_reason STRING(255),
tgt_price_label_nr STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);