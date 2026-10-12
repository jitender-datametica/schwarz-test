CREATE TABLE IF NOT EXISTS ldl_etl_process.t_etl_cdc_dim_table_dependency_1 (
parent_db STRING(15) COLLATE 'und:ci' NOT NULL,
parent_table STRING(200) COLLATE 'und:ci' NOT NULL,
parent_pk STRING(500) COLLATE 'und:ci' NOT NULL,
child_db STRING(15) COLLATE 'und:ci' NOT NULL,
child_table STRING(200) COLLATE 'und:ci' NOT NULL,
child_pk STRING(500) COLLATE 'und:ci' NOT NULL,
parent_key STRING(100) COLLATE 'und:ci' NOT NULL,
child_key STRING(100) COLLATE 'und:ci' NOT NULL,
parent_attributes STRING(500) COLLATE 'und:ci' NOT NULL,
child_attributes STRING(500) COLLATE 'und:ci' NOT NULL,
is_active BOOL NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL
);