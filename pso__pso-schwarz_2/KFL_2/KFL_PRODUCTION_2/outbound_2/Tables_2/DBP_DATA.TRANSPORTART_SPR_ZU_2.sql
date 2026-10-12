CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transportart_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
transportart_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);