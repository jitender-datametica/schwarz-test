CREATE OR REPLACE TABLE kfl_production_dbp_data.mcx_l_abschlussstatus (
abschluss_id INTEGER NOT NULL,
umfrage_id INTEGER DEFAULT - 1 NOT NULL,
abschluss_bez STRING(20) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);