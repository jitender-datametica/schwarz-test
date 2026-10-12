CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbe_medium_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
medien_kz STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);