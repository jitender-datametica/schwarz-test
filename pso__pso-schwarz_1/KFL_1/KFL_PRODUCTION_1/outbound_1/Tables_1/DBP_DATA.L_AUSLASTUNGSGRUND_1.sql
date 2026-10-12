CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_auslastungsgrund_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
auslastungsgrund_id BIGNUMERIC(38,0) NOT NULL,
sap_auslastungsgrund STRING(20) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);