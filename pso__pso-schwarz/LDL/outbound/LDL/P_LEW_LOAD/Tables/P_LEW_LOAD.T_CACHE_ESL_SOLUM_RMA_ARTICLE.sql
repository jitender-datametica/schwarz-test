CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_esl_solum_rma_article (
src_id BIGNUMERIC(38,0),
src_article_id STRING(255),
src_article_name STRING(255),
src_item_group BIGNUMERIC(38,0),
src_defect_label_id BIGNUMERIC(38,0),
src_filename STRING(1000),
src_db_host STRING(255),
tgt_id BIGNUMERIC(38,0),
tgt_instance STRING(255),
tgt_article_id STRING(255),
tgt_article_name STRING(255),
tgt_item_group BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);