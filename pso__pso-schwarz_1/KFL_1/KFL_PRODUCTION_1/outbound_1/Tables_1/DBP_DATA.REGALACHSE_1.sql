CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.regalachse_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
regalachse_id BIGNUMERIC(38,0) NOT NULL,
layoutbaustein_id BIGNUMERIC(38,0),
layoutbaustein_version BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
fbb_nr STRING(20) COLLATE 'und:ci' NOT NULL,
platzierungsstufe_id STRING(3) COLLATE 'und:ci',
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
achsgruppe_id BIGNUMERIC(38,0),
regalachse_flaeche NUMERIC(9,2) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);