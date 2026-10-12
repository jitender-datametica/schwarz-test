CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.layoutbaustein_wup_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
layoutbaustein_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
aktiv_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);