CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lager_bewgrund_spr_zu (
grund_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
hist_fg BIGNUMERIC(38,0) NOT NULL,
grund_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);