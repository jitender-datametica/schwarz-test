CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_immo_zustaendig_2 (
mandant_id INTEGER NOT NULL,
zustaendig_id INTEGER NOT NULL,
vorname STRING(40) COLLATE 'und:ci',
nachname STRING(40) COLLATE 'und:ci',
anrede STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);