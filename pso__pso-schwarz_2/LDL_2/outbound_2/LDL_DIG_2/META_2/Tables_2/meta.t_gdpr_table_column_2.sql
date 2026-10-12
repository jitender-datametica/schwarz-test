CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_table_column_2 (
table_column_id INTEGER NOT NULL,
deletion_table_id INTEGER NOT NULL,
column_name STRING(250),
active STRING(1),
tmsp_insert DATETIME,
tmsp_update DATETIME
);