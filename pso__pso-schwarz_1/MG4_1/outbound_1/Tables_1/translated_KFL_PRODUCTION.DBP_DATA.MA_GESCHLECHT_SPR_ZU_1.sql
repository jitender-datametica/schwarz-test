CREATE OR REPLACE TABLE kfl_production_dbp_data.ma_geschlecht_spr_zu_1 (
mandant_id INTEGER NOT NULL,
geschlecht_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
geschlecht_bez STRING(10) COLLATE 'und:ci',
anrede_bez STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);