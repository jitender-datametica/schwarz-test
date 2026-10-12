CREATE TABLE IF NOT EXISTS szd_etl_process.t_cache_lot_order_1 (
lot_nr STRING(50),
sap_order_numbers STRING(5000),
valid_from TIMESTAMP NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_src_file_name STRING(500) NOT NULL,
dwh_src_1_tmsp TIMESTAMP NOT NULL,
valid_to TIMESTAMP
);