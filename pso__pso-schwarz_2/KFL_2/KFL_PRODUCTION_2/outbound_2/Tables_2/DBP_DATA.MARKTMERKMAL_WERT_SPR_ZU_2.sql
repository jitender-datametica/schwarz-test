CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktmerkmal_wert_spr_zu_2 (
marktmerkmal_id STRING(4) COLLATE 'und:ci' NOT NULL,
marktmerkmal_wert STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
marktmerkmal_wert_bez STRING(30) COLLATE 'und:ci',
marktmerkmal_wert_kbez STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);