CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.blockbestand_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
prozess_id BIGNUMERIC(38,0) NOT NULL,
dat_bis DATE NOT NULL,
menge_blockbestand NUMERIC(13,3) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);