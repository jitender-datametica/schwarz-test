CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.dvg_columns_2 (
databasename STRING(30) COLLATE 'und:ci' NOT NULL,
tablename STRING(30) COLLATE 'und:ci' NOT NULL,
columnname STRING(30) COLLATE 'und:ci' NOT NULL,
basedatatype STRING(255) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);