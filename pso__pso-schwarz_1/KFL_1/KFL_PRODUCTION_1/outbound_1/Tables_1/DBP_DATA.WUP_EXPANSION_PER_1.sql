CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_expansion_per_1 (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
expansionstyp_id BIGNUMERIC(38,0) NOT NULL,
filialart_id BIGNUMERIC(38,0),
dat_bis DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);