CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_filialwechsel_1 (
idpersonal BIGNUMERIC(38,0) NOT NULL,
idcompany BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
idcompany_nach BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
idabteilungen BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);