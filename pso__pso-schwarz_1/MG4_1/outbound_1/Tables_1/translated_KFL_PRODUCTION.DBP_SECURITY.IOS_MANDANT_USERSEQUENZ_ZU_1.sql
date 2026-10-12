CREATE OR REPLACE TABLE kfl_production_dbp_security.ios_mandant_usersequenz_zu_1 (
mandant_id INTEGER NOT NULL,
usersequenz STRING(10000) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);