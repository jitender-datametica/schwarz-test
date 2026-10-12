CREATE OR REPLACE TABLE kfl_production_dbp_etl.mis_q_kunden_gleich_2 (
mandant_id INTEGER,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat DATE NOT NULL,
dat_gleich DATE,
bonanzahl NUMERIC(18,2)
);