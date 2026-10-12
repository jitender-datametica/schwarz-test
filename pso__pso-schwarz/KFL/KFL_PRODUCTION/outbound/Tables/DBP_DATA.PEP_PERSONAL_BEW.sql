CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_personal_bew (
idpersonal BIGNUMERIC(38,0) NOT NULL,
idcompany BIGNUMERIC(38,0) NOT NULL,
kom_geh_fg BIGNUMERIC(38,0) NOT NULL,
zeit_kom_geh DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);