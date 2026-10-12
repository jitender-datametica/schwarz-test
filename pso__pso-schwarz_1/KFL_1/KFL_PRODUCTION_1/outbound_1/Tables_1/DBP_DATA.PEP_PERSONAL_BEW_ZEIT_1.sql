CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_personal_bew_zeit_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
idcompany BIGNUMERIC(38,0) NOT NULL,
idpersonal BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
zeit_kom BIGNUMERIC(38,0) NOT NULL,
zeit_sekunden BIGNUMERIC(38,0) NOT NULL,
zeit_kom_orig_fg BIGNUMERIC(38,0) NOT NULL,
zeit_geh_orig_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);