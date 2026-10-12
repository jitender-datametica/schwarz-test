CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rueckfuehrung_lt_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
tour_id INTEGER NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
lagerbew_beleg_id INTEGER NOT NULL,
kj BIGNUMERIC(38,0) NOT NULL,
lfnr BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
mandant_id_lager BIGNUMERIC(38,0),
wup_id_lager BIGNUMERIC(38,0),
nb_id_lager BIGNUMERIC(38,0),
dat_buch DATE NOT NULL,
menge_bme NUMERIC(18,3) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP,
anz_stp NUMERIC(13,3),
wertstoffturm_nr BIGNUMERIC(38,0)
);