CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pep_ma_funktion_1 (
pep_ma_funktion_id BIGNUMERIC(38,0) NOT NULL,
pep_ma_funktion_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);