CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_wawi_extract_control_status_2 (
schema_name STRING(100) NOT NULL,
table_name STRING(100) NOT NULL,
wawi_instanz_kzl STRING(3) NOT NULL,
wh_nr INTEGER NOT NULL,
last_scn INTEGER DEFAULT 0,
max_scn INTEGER DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL,
ai_graph_name STRING(100) NOT NULL,
PRIMARY KEY (schema_name, table_name, wawi_instanz_kzl, wh_nr, ai_graph_name) NOT ENFORCED
);