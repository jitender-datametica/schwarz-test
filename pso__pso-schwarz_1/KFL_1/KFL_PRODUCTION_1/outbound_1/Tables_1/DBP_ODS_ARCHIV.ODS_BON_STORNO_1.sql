CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_bon_storno_1 (
bon_id STRING(100) NOT NULL,
bon_dat DATE NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
bon_nr BIGNUMERIC(38,0) NOT NULL,
kasse_nr BIGNUMERIC(38,0) NOT NULL,
datei_name STRING(1020),
td_insert TIMESTAMP,
td_update TIMESTAMP
);