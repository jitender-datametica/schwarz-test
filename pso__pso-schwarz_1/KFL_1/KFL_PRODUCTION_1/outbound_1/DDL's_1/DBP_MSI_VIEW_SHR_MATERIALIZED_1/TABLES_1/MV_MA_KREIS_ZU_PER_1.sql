CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_ma_kreis_zu_per_1 (
mandant_id INTEGER,
mitarbeiter_kreis_id STRING(2) COLLATE 'und:ci',
mitarbeiter_id STRING(20),
dat_von DATE,
dat_bis DATE,
kjmo INTEGER,
kjmo_von INTEGER,
kjmo_bis INTEGER
);