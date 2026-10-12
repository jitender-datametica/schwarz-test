CREATE OR REPLACE TABLE kfl_production_dbp_data.mdl_zeitspanne_einkauf_spr_zu_1 (
zeitspanne_einkauf_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
zeitspanne_einkauf_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);