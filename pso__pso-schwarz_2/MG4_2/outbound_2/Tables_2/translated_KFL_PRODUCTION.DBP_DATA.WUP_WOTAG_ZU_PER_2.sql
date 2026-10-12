CREATE OR REPLACE TABLE kfl_production_dbp_data.wup_wotag_zu_per_2 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wtag_id INTEGER NOT NULL,
umsatz_prz NUMERIC(9,3),
dat_von DATE,
dat_bis DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);