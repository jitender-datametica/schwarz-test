CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.zaehl_grund_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zaehl_grund_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zaehl_grund_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);