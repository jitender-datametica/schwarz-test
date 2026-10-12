CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_wawi_extract_control_status_2 (
schema_name STRING(100) NOT NULL,
table_name STRING(100) NOT NULL,
wawi_instanz_kzl STRING(3) NOT NULL,
wh_nr INTEGER NOT NULL,
ai_graph_name STRING(100) NOT NULL,
last_scn BIGNUMERIC(38,0) DEFAULT 0,
max_scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (schema_name, table_name, wawi_instanz_kzl, wh_nr, ai_graph_name) NOT ENFORCED
);