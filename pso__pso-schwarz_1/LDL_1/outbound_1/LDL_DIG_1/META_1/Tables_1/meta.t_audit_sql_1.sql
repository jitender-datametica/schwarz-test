CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_audit_sql_1 (
id INTEGER,
update_key STRING(250),
curated_entity STRING(100),
pset_name STRING(100),
pset_wait TIMESTAMP,
pset_start TIMESTAMP,
pset_end TIMESTAMP,
file_processed STRING(500)
);