CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lager_bewart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) DEFAULT 7 NOT NULL,
lager_bewart_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);