CREATE OR REPLACE TABLE kfl_production_dbp_etl.mis_q_kunden_abw_avg (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat DATE NOT NULL,
bonanzahl NUMERIC(18,2),
bonanzahl_avg NUMERIC(18,2),
abweichung_prz NUMERIC(6,2)
);