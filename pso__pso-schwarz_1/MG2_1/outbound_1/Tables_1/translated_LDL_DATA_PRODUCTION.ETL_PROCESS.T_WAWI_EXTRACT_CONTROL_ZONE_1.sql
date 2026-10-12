CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_wawi_extract_control_zone_1 (
zone_seq INTEGER NOT NULL,
country_1 STRING(3) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL
);