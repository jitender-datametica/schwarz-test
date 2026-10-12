CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_debitor_per_1 (
debitor_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
debitor_status_id STRING(3) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
konzern_id INTEGER,
konzessionaer_id STRING(20) COLLATE 'und:ci',
ivs_fg INTEGER DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);