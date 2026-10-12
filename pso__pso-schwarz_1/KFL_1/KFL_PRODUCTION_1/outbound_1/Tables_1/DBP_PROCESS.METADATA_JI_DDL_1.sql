CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.metadata_ji_ddl_1 (
databasename STRING(128) COLLATE 'und:ci' NOT NULL,
tablename STRING(128) COLLATE 'und:ci' NOT NULL,
requesttext STRING(4000) COLLATE 'und:ci' NOT NULL,
commentstring STRING(4000) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);