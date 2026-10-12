CREATE OR REPLACE TABLE kfl_production_dbp_etl.mis_q_umsatz_neg (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat DATE,
umsatz_netto NUMERIC(18,2)
);