CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.snfl_track_deltas (
databasename STRING(128) COLLATE 'und:ci',
tablename STRING(128) COLLATE 'und:ci',
kl_product STRING(128) COLLATE 'und:ci',
collecttimestamp DATETIME,
td_insert TIMESTAMP,
td_update TIMESTAMP
);