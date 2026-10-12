CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_l_abschlussstatus_2 (
abschluss_id BIGNUMERIC(38,0) NOT NULL,
umfrage_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
abschluss_bez STRING(20) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);