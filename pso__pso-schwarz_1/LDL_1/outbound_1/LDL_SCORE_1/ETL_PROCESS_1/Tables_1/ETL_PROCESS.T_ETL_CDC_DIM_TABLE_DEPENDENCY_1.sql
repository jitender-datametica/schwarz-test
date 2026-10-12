CREATE TABLE IF NOT EXISTS ldl_score_etl_process.t_etl_cdc_dim_table_dependency_1 (
parent_db STRING(8),
parent_table STRING(200),
parent_pk STRING(500),
child_db STRING(8),
child_table STRING(200),
child_pk STRING(500),
parent_key STRING(100),
child_key STRING(100),
parent_attributes STRING(500),
child_attributes STRING(500),
is_active BOOL,
dwh_load_id INTEGER,
dwh_created TIMESTAMP,
dwh_updated TIMESTAMP
);