CREATE OR REPLACE TABLE kfl_production_dbp_data.l_pers_teilbereich (
mandant_id INTEGER NOT NULL,
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungskreis_id INTEGER NOT NULL,
pers_bereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
modsz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);