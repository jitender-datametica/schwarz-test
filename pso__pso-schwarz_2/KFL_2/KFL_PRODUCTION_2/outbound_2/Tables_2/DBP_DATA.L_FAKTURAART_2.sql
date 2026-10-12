CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_fakturaart_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
fakturaart_id STRING(4) NOT NULL,
soll_haben_kz STRING(1) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);