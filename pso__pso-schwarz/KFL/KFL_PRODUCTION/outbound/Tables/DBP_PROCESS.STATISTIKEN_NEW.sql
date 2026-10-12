CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.statistiken_new (
databasename STRING(40) COLLATE 'und:ci',
tablename STRING(40) COLLATE 'und:ci',
columnname STRING(40) COLLATE 'und:ci',
spalte_stat STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat1 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat2 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat3 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat4 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat5 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat6 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat7 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat8 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat9 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
komb_stat10 STRING(1) COLLATE 'und:ci' DEFAULT ' ',
td_update TIMESTAMP,
td_insert TIMESTAMP
);