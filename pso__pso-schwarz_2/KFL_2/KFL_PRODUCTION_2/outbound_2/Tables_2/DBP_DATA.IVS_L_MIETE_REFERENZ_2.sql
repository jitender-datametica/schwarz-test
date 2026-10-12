CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_miete_referenz_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
miete_referenz_id STRING(4) COLLATE 'und:ci' NOT NULL,
miete_referenz_bez STRING(40) COLLATE 'und:ci',
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);