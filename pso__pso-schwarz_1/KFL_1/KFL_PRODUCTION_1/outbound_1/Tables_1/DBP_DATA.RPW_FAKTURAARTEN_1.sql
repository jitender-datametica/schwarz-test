CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpw_fakturaarten_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL,
vertriebbelegtyp_id STRING(1) COLLATE 'und:ci',
soll_haben_kz STRING(1) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);