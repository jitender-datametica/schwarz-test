CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lager_einheiten_typ_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
lager_einheiten_typ STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);