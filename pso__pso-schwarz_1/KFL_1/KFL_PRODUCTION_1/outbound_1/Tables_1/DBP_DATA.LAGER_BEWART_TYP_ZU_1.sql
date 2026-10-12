CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lager_bewart_typ_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
grund_id STRING(10) COLLATE 'und:ci' NOT NULL,
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
hist_fg BIGNUMERIC(38,0) NOT NULL,
lager_bewart_typ_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);