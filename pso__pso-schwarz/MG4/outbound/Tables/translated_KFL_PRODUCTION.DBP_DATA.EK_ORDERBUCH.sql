CREATE OR REPLACE TABLE kfl_production_dbp_data.ek_orderbuch (
art_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
ek_orderbuch_nr INTEGER NOT NULL,
gp_id INTEGER DEFAULT - 1 NOT NULL,
einkaufsorganisation_id INTEGER DEFAULT 0 NOT NULL,
vz_wup_id INTEGER,
vz_nb_id INTEGER,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
gesperrt_fg INTEGER DEFAULT 0 NOT NULL,
fix_gp_fg INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);