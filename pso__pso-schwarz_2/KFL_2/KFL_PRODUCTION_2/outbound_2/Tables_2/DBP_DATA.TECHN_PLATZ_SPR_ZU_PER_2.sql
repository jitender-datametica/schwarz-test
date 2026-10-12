CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.techn_platz_spr_zu_per_2 (
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
tech_platz_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);