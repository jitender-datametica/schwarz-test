CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_market_research_map_features_niq_rpfmcg_2 (
country_cd STRING(50) NOT NULL,
data_src_segment_name STRING(100) NOT NULL,
fe_feature_name STRING(100),
technical_feature_name STRING(100) NOT NULL,
source_char_desc STRING(100),
column_name STRING(100) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.')
);