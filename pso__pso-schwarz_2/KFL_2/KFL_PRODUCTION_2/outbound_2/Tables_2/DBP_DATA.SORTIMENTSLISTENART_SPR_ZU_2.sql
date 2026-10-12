CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sortimentslistenart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sortimentslistenart_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sortimentslistenart_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);