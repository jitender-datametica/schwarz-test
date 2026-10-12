CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_pre_sql (
sql_id INTEGER NOT NULL,
sql_name STRING(250),
sql STRING(2000),
type_cd STRING(250),
tmsp_insert DATETIME,
tmsp_update DATETIME
);