CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cl_punkt_spr_zu_per_2 (
checkliste_punkt_id STRING(32) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
cl_punkt_bez STRING(40) COLLATE 'und:ci' NOT NULL,
cl_punkt_langtext STRING(320) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);