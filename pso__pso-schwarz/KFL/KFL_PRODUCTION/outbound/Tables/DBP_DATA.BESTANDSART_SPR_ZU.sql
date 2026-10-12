CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bestandsart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
bestandsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
bestandsart_bez STRING(30) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);