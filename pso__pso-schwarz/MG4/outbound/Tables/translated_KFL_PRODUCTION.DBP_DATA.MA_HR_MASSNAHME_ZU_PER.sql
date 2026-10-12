CREATE OR REPLACE TABLE kfl_production_dbp_data.ma_hr_massnahme_zu_per (
mandant_id INTEGER NOT NULL,
hr_massnahme_grund_id STRING(2) COLLATE 'und:ci' NOT NULL,
hr_massnahme_id STRING(2) COLLATE 'und:ci' NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);