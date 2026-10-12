CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lohnart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lohnart_id STRING(5) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lohnart_bez STRING(25) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);