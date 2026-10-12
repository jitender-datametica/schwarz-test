CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.kasse_storno_1 (
bon_id STRING(40) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) DEFAULT 0,
kasse_nr BIGNUMERIC(38,0),
bon_nr BIGNUMERIC(38,0),
dat_bon DATE NOT NULL,
md5_hash STRING(25) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);