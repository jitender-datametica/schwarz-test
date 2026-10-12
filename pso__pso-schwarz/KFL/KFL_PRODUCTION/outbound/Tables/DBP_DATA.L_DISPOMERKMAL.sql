CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_dispomerkmal (
mandant_id BIGNUMERIC(38,0) NOT NULL,
dispomerkmal STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);