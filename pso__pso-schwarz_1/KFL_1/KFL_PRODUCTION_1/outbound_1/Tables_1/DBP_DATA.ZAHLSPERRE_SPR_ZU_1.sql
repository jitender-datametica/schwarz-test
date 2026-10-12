CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.zahlsperre_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
zahlsperre_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zahlsperre_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);