CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_esl_solum_end_device_articles_2 (
src_label_code STRING(255),
src_article_id STRING(255),
src_seq BIGNUMERIC(38,0),
src_station_code STRING(255),
src_db_host STRING(255),
src_filename STRING(1000),
tgt_price_label_nr STRING(100),
tgt_instance STRING(255),
tgt_item_nr STRING(255),
tgt_station_id STRING(255),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);