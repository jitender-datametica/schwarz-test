CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vorgangsart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vorgangsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
vorgangsart_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);