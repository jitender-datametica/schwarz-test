CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rech_kontoart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rech_kontoart_id STRING(1) COLLATE 'und:ci' NOT NULL,
rech_kontoart_bez STRING(40) COLLATE 'und:ci',
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);