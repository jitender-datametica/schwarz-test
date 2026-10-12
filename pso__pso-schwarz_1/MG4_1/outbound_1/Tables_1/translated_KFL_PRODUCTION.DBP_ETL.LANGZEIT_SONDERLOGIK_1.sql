CREATE OR REPLACE TABLE kfl_production_dbp_etl.langzeit_sonderlogik_1 (
mandant_id INTEGER NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
gj INTEGER NOT NULL,
dat_von_p DATE,
dat_bis_p DATE,
abwesenheit_pflege NUMERIC(9,2),
abwesenheit_eltern NUMERIC(9,2),
dat_von_e DATE,
dat_bis_e DATE,
ranking INTEGER
);