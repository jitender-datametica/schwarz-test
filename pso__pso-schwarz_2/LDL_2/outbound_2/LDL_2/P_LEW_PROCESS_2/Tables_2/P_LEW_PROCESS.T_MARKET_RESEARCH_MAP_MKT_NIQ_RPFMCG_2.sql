CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_market_research_map_mkt_niq_rpfmcg_2 (
market_id BIGNUMERIC(38,0) NOT NULL,
data_src_segment_name STRING(100) NOT NULL,
market_descr STRING(200),
country_cd STRING(10) NOT NULL,
channel_type_name STRING(100),
channel_name STRING(100),
geography_type_name STRING(100),
geography_name STRING(100),
region_type_cd STRING(100),
lidl_included_cd STRING(100),
lidl_vges_id BIGNUMERIC(38,0),
excluded_fg BIGNUMERIC(38,0),
benchmark_cd STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related change.')
);