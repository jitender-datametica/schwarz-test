CREATE OR REPLACE TABLE kfl_production_dbp_data.kostenart_spr_zu_1 (
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id INTEGER NOT NULL,
kostenart_bez STRING(40),
td_update TIMESTAMP,
td_insert TIMESTAMP
);