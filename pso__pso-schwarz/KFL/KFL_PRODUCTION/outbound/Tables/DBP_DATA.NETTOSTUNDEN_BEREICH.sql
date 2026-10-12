CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.nettostunden_bereich (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
hr_objekt_bereich_id BIGNUMERIC(38,0) NOT NULL,
stunden NUMERIC(10,2),
quelle_id BIGNUMERIC(38,0),
stunden_typ_fg BIGNUMERIC(38,0) NOT NULL,
dat_zeit_aenderung DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);