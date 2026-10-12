CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_wawi_extract_control_1 (
schema_name STRING(100) NOT NULL,
table_name STRING(100) NOT NULL,
active_fg BOOL NOT NULL,
delta_fg BOOL NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL,
PRIMARY KEY (schema_name, table_name) NOT ENFORCED
);