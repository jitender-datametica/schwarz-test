CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_planung_fehlgrund_1 (
idpersonal BIGNUMERIC(38,0) NOT NULL,
idcompany BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
idfehlgrund BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);