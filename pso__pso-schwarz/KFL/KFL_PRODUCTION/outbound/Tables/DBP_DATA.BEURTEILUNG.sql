CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.beurteilung (
beurteilung_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
mandant_id BIGNUMERIC(38,0),
eindruck_gesamt STRING(50),
note_gesamt NUMERIC(9,2),
dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);