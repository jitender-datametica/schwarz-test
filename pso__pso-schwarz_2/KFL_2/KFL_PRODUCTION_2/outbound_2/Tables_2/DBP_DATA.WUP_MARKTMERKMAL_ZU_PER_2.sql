CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_marktmerkmal_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_guid STRING(32) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
marktmerkmal_id STRING(4) COLLATE 'und:ci',
marktmerkmal_wert STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);