CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_wawi_extract_control_zone (
zone_seq INTEGER NOT NULL,
country STRING(3) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL
);