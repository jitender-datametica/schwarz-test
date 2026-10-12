CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verrechfallart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verrechfallart_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
verrechfallart_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);