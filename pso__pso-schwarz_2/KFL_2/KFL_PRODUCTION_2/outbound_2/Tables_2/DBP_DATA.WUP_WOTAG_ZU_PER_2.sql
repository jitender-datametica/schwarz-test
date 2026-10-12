CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_wotag_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wtag_id BIGNUMERIC(38,0) NOT NULL,
umsatz_prz NUMERIC(9,3),
dat_von DATE,
dat_bis DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);