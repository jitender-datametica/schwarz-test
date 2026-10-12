CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerort_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lagerort_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);