CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_instanz_autodispo_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
instanz STRING(3) COLLATE 'und:ci' NOT NULL,
dat_von DATE,
modus STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);