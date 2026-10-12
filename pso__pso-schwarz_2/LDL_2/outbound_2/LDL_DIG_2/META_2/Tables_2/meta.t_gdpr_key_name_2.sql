CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_key_name_2 (
key_name_id INTEGER NOT NULL,
key_name STRING(250),
key_type_id INTEGER NOT NULL,
retain BOOL,
tmsp_insert DATETIME,
tmsp_update DATETIME
);