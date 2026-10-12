CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.collstatsinclude (
databasename STRING(30) COLLATE 'und:ci',
tablename STRING(30) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);