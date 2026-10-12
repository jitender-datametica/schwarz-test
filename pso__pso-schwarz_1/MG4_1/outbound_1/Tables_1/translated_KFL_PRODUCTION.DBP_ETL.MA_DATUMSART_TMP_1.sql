CREATE OR REPLACE TABLE kfl_production_dbp_etl.ma_datumsart_tmp_1 (
mandant_id INTEGER NOT NULL,
datumsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
kjmo INTEGER
);