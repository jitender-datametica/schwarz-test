CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lager_bewgrund_2 (
grund_id STRING(10) COLLATE 'und:ci' NOT NULL,
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
hist_fg BIGNUMERIC(38,0) NOT NULL,
retourenart_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);