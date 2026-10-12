CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.l_bon_wup_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
bda_anym_fg BIGNUMERIC(38,0) NOT NULL,
gesperrt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dat DATE NOT NULL,
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);