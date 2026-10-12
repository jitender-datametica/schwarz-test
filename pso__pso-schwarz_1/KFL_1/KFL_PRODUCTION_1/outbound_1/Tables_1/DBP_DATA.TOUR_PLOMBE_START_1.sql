CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tour_plombe_start_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
tour_id INTEGER NOT NULL,
plombe_id BIGNUMERIC(38,0) NOT NULL,
plombe_pos_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0),
plombe_vorgang_id STRING(1) COLLATE 'und:ci',
dat_erfasst DATE NOT NULL,
zeit_erfasst BIGNUMERIC(38,0) NOT NULL,
storno_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);