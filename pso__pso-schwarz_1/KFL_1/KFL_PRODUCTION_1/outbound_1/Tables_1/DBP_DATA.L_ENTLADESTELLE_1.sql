CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_entladestelle_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
entladestelle_id BIGNUMERIC(38,0) NOT NULL,
gatename STRING(255) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);