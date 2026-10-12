CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.pep_kassentyp (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
pep_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
kasse_von BIGNUMERIC(38,0) NOT NULL,
kasse_bis BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);