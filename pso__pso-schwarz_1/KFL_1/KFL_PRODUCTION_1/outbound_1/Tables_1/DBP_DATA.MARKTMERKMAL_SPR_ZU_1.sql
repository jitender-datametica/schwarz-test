CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktmerkmal_spr_zu_1 (
marktmerkmal_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
marktmerkmal_bez STRING(30) COLLATE 'und:ci',
marktmerkmal_kbez STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);