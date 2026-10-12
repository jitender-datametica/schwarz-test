CREATE OR REPLACE TABLE kfl_production_dbp_data.l_buchungskreis_2 (
system_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
buchungskreis_id INTEGER NOT NULL,
gj_variante_id STRING(2) COLLATE 'und:ci' NOT NULL,
land_id STRING(2) COLLATE 'und:ci' NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
kontenplan_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungskreis_glob_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);