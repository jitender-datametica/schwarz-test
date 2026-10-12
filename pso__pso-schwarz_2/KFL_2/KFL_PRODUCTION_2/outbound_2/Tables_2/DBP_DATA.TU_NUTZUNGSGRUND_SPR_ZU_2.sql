CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tu_nutzungsgrund_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lager STRING(4) COLLATE 'und:ci' NOT NULL,
tu_nutzungsgrund_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
tu_nutzungsgrund_bez STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);