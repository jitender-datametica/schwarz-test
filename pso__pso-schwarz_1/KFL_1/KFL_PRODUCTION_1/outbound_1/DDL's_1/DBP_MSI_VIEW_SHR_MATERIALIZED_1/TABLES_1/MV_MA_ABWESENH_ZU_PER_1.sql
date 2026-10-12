CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_ma_abwesenh_zu_per_1 (
mandant_id INTEGER,
abwesenheit_id STRING(4) COLLATE 'und:ci',
abwesenheit_bez STRING(30) COLLATE 'und:ci',
mitarbeiter_id STRING(20),
dat_von DATE,
dat_bis DATE,
kjmo INTEGER,
kjmo_von INTEGER,
kjmo_bis INTEGER,
dauer_tage INTEGER,
abwesenheit_stunden NUMERIC(29,2)
);