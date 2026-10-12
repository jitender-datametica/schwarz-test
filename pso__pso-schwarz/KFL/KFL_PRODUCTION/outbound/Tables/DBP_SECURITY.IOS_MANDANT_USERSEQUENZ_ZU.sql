CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.ios_mandant_usersequenz_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
usersequenz STRING(10000) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);