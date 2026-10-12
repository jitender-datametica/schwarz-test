CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_error_1 (
error_id INTEGER NOT NULL,
origin STRING(250),
context STRING(250),
error STRING(2000),
tmsp_insert DATETIME,
tmsp_update DATETIME
);