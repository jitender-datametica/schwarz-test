CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_table_type_cd (
table_type_cd_id INTEGER NOT NULL,
deletion_table_id INTEGER NOT NULL,
type_cd STRING(10) NOT NULL,
active STRING(1),
tmsp_insert DATETIME,
tmsp_update DATETIME
);