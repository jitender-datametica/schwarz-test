CREATE OR REPLACE TABLE kfl_production_dbp_etl.lang_hr_abwesend_tmp_1 (
mandant_id INTEGER NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
gj INTEGER NOT NULL,
krank_tage NUMERIC(9,2),
abwesenheit_tage NUMERIC(9,2),
ranking INTEGER
);