CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rueckfuehrung_lt_grund_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
tour_id INTEGER NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
lagerbew_beleg_id INTEGER NOT NULL,
kj BIGNUMERIC(38,0) NOT NULL,
lfnr BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
rueck_grund_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dat_buch DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);