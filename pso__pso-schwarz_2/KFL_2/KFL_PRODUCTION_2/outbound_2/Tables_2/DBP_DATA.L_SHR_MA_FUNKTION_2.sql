CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_shr_ma_funktion_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
shr_ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);