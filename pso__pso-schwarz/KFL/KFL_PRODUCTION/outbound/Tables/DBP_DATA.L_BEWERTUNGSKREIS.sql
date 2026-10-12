CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bewertungskreis (
mandant_id BIGNUMERIC(38,0) NOT NULL,
bewertungskreis_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) DEFAULT 7 NOT NULL,
buchungskreis_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);