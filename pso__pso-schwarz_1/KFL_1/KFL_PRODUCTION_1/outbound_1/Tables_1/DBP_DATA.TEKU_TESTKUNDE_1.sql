CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_testkunde_1 (
testkunde_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
testkunde_name STRING(255) COLLATE 'und:ci',
testkunde_vorname STRING(255) COLLATE 'und:ci',
testkunde_anrede STRING(40) COLLATE 'und:ci',
testkunde_funktion STRING(7) COLLATE 'und:ci',
testkunde_dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);