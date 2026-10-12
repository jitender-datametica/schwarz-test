CREATE OR REPLACE TABLE kfl_production_dbp_etl.mis_q_umsatz_abw_avg_1 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat DATE NOT NULL,
umsatz_netto NUMERIC(18,2),
umsatz_netto_avg NUMERIC(18,2),
umsatzabweichung_prz NUMERIC(12,2)
);