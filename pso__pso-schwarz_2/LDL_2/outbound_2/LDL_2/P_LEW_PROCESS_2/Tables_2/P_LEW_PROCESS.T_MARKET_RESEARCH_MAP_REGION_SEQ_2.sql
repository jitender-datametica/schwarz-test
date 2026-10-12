CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_market_research_map_region_seq_2 (
country_cd STRING(10) NOT NULL,
geography_name STRING(100),
geography_value STRING(100),
display_seq STRING(100),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.')
);