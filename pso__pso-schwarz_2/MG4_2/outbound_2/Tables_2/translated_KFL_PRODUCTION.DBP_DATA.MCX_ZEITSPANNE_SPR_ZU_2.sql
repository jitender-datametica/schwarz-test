CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_zeitspanne_spr_zu_2 (
zeitspanne_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
zeitspanne_bez STRING(150) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);