CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.korrekturart_spr_zu (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
korrekturart_id STRING(1) COLLATE 'und:ci' NOT NULL,
korrekturart_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);