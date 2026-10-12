CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_werk (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
werk_nr STRING(4) COLLATE 'und:ci' NOT NULL,
werk_name STRING(30) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
sako_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);