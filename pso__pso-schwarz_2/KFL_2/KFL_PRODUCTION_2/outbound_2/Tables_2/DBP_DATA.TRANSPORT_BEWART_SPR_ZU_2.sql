CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transport_bewart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lvs_bewart_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lvs_bewart_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);