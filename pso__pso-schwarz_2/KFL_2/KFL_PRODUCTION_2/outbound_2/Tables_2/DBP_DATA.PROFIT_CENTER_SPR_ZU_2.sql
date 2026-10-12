CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.profit_center_spr_zu_2 (
pc_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
pc_bez STRING(40),
td_insert TIMESTAMP,
td_update TIMESTAMP
);