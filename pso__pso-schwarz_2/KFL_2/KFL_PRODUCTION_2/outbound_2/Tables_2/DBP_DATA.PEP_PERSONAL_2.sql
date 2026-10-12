CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_personal_2 (
idpersonal BIGNUMERIC(38,0) NOT NULL,
dat_austritt DATE,
pep_ma_name STRING(40) COLLATE 'und:ci',
pep_ma_vorname STRING(40) COLLATE 'und:ci',
geschlecht_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);