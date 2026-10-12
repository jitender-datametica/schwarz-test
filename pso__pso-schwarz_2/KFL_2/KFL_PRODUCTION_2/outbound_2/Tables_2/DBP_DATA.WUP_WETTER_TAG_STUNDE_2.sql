CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_wetter_tag_stunde_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
zeit_stunde BIGNUMERIC(38,0) NOT NULL,
datzeit_letztes_update DATETIME NOT NULL,
temperatur BIGNUMERIC(38,0),
wetterzustand_id BIGNUMERIC(38,0),
windgeschwindigkeit BIGNUMERIC(38,0),
regenrisiko BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);