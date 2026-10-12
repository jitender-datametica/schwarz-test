CREATE OR REPLACE TABLE kfl_production_dbp_data.ma_gruppe_zu_per_2 (
mandant_id INTEGER NOT NULL,
mitarbeiter_gruppe_id STRING(1) COLLATE 'und:ci' NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);