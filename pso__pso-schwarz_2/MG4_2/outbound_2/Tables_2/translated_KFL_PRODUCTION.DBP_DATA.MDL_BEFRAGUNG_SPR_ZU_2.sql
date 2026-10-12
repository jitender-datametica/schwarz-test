CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_befragung_spr_zu_2 (
befragung_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
befragung_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);