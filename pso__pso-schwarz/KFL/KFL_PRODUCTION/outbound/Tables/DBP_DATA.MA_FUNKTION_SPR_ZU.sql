CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_funktion_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ma_funktion_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);