CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_bereich_spr_zu_1 (
ber_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
ber_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);