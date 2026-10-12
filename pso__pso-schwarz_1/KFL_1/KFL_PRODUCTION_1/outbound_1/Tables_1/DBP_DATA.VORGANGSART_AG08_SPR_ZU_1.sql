CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vorgangsart_ag08_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
vorgangsart_ag08_id STRING(2) COLLATE 'und:ci' NOT NULL,
vorgangsart_ag08_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);