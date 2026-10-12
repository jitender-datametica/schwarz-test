CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.planungsart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
planungsart_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
planungsart_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);