CREATE TABLE IF NOT EXISTS nfpow_etl_process.extraction_integration_ctrl_1 (
sourcesystem STRING(3) NOT NULL,
tablename STRING(500) NOT NULL,
extraction_type STRING(20) NOT NULL,
extraction_timestamp DATETIME NOT NULL,
load_timestamp DATETIME,
start_date DATE,
end_date DATE,
country_1 STRING(500),
country_logic STRING(20)
);