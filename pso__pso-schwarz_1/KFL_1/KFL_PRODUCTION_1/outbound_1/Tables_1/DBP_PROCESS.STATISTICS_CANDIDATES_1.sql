CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.statistics_candidates_1 (
databasename STRING(40) COLLATE 'und:ci',
tablename STRING(40) COLLATE 'und:ci',
columns STRING(1024) COLLATE 'und:ci',
statstyp STRING(1) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);