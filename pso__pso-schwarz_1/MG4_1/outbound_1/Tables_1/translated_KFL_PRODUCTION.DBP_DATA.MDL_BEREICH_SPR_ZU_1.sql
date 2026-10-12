CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_bereich_spr_zu_1 (
bereich_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
bereich_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);