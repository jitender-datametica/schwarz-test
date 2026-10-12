CREATE OR REPLACE TABLE kfl_production_dbp_etl.mis_q_umsatz_1 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat DATE NOT NULL,
dat_vgl DATE NOT NULL,
umsatz_netto NUMERIC(18,2),
umsatzgleich_fg INTEGER NOT NULL,
umsatzavg_fg INTEGER NOT NULL,
umsatz_fg INTEGER NOT NULL
);