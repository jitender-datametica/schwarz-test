CREATE OR REPLACE TABLE kfl_production_dbp_etl.d_tanktresor_help_2 (
marktnummer STRING(4) COLLATE 'und:ci',
wg_text STRING(40) COLLATE 'und:ci',
schluessel2 STRING(20) COLLATE 'und:ci',
wert STRING(30) COLLATE 'und:ci',
datum STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);