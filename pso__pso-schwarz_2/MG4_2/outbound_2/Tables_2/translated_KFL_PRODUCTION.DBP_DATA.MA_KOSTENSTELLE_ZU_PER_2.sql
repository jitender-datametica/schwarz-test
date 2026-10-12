CREATE OR REPLACE TABLE kfl_production_dbp_data.ma_kostenstelle_zu_per_2 (
mandant_id INTEGER NOT NULL,
system_id INTEGER NOT NULL,
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);