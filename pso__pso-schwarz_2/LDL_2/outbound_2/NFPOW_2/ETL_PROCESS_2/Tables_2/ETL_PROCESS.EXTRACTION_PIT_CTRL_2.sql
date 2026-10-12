CREATE TABLE IF NOT EXISTS nfpow_etl_process.extraction_pit_ctrl_2 (
schema_name STRING(16777216) OPTIONS(description='Name of the schema from NFPOW.P_LEW_MART_PIT.T_CNTL_EXPORT_LOADING_2'),
table_name STRING(16777216) OPTIONS(description='Name of the table from NFPOW.P_LEW_MART_PIT.T_CNTL_EXPORT_LOADING_2'),
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Client ID from NFPOW.P_LEW_MART_PIT.T_CNTL_EXPORT_LOADING_2'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created from NFPOW.P_LEW_MART_PIT.T_CNTL_EXPORT_LOADING_2'),
extraction_ts DATETIME OPTIONS(description='Timestamp when data was exported')
) OPTIONS(description='Information about extractions from PIT tables');