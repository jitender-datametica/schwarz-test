CREATE OR REPLACE TABLE kfl_production_dbp_security.user_mandant_msiprodukt_zu_1 (
mandant_id INTEGER NOT NULL,
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
msi_produkt_bez STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);