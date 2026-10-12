CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tarifgebiet_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
tarifgebiet_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
tarifgebiet_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);