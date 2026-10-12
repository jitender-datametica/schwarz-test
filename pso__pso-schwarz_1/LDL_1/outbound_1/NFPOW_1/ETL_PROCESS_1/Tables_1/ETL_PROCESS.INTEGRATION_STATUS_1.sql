CREATE TABLE IF NOT EXISTS nfpow_etl_process.integration_status_1 (
source_system STRING(3) NOT NULL,
job_name STRING(500) NOT NULL,
country_1 STRING(10) NOT NULL,
run_date DATE NOT NULL,
integration_finished_timestamp DATETIME NOT NULL
);