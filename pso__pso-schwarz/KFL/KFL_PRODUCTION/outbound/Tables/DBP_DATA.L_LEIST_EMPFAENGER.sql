CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_leist_empfaenger (
mandant_id BIGNUMERIC(38,0) NOT NULL,
leist_empfaenger_sap_id STRING(30) COLLATE 'und:ci' NOT NULL,
leist_empfaenger_gruppe_id STRING(30) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
ext_ma_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);