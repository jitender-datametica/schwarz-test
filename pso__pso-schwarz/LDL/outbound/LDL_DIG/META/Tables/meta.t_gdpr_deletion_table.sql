CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_deletion_table (
deletion_table_id INTEGER,
table_schema_id INTEGER NOT NULL,
table_nam STRING(250),
del_action STRING(10),
active STRING(1),
tmsp_insert DATETIME,
tmsp_update DATETIME,
table_alias STRING(50),
priority INTEGER
);