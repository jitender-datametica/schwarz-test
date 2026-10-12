CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_bq_data_2 (
src JSON,
file_name STRING(1000),
insert_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);