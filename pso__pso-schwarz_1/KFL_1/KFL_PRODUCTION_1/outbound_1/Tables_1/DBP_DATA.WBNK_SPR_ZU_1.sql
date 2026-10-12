CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbnk_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wbnk_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wbnk_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);