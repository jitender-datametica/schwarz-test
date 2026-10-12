CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_esl_solum_rma_defect_reason (
src_id BIGNUMERIC(38,0),
src_reason_active INTEGER,
src_reason_code STRING(250),
src_reason_order INTEGER,
src_filename STRING(1000),
src_db_host STRING(255),
tgt_id BIGNUMERIC(38,0),
tgt_instance STRING(255),
tgt_reason_active INTEGER,
tgt_reason_description STRING(250),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);