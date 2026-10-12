CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_csr_produktgruppe (
csr_produktgruppe_id BIGNUMERIC(38,0) NOT NULL,
csr_produktgruppe_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);